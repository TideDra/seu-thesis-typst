#import "constants.typ": 字体, 字号, 行距
#import "@preview/a2c-nums:0.0.1": int-to-cn-num
#import "@preview/cuti:0.2.0": show-cn-fakebold

#let part_state = state("part")

// 使用terms模拟latex的paragraph
#let paragraph(content) = {
  set terms(hanging-indent: 0pt, indent: 0pt)
  set par(first-line-indent: 0pt)
  content
  [#v(-18pt)\ ]
}

// 获取当前章节序号
#let get_chapter_idx(loc: auto) = {
  if loc == auto {
    loc = here()
  }
  counter(heading).at(loc).first()
}

// 获取用于显示的章节序号
#let get_chapter_idx_display(loc: auto) = {
  if loc == auto {
    loc = here()
  }
  return numbering(
    if part_state.at(loc) == "appendix" {
      "A"
    } else {
      "1"
    },
    counter(heading).at(loc).first(),
  )
}

// 使用typst的画圈功能实现带圈数字
#let my_circle_number(num, size, inset: 0pt, stroke: 0.5pt) = {
  set text(size: size)
  let circle_size = size / 2
  box(
    circle(radius: circle_size, inset: inset, stroke: stroke)[
      #set align(center)
      #num
    ],
  )
}

// 使用unicode带圈数字
#let circle_number(num) = {
  // only support 0~50
  if num == 0 {
    str.from-unicode(9450)
  } else if 1 <= num and num <= 20 {
    str.from-unicode(9311 + num)
  } else if 21 <= num and num <= 35 {
    str.from-unicode(12860 + num)
  } else if 36 <= num and num <= 50 {
    str.from-unicode(12941 + num)
  } else {
    panic("circled number not supported: " + str(num))
  }
}

// 子图
#let subfigure = figure.with(
  kind: "subfigure",
  supplement: none,
  numbering: "(a)",
  placement: none,
)

// 设置脚注格式。该函数必须在文档开头调用。
#let set_doc_footnote(doc) = {
  // 使用带圈数字
  set footnote(numbering: (..nums) => {
    set text(size: 6pt, baseline: -4.5pt)
    circle_number(nums.pos().first())
  })

  // 自定义脚注项，调整字号、间距
  show footnote.entry: it => {
    let loc = it.note.location()
    let idx = counter(footnote).at(loc).first()
    if idx == 1 {
      v(6pt)
    }
    h(-0.5em)
    text(size: 4.5pt, baseline: -3.1pt, circle_number(idx))
    h(3pt)
    text(size: 9pt, font: 字体.宋体, it.note.body)
  }

  doc
}

// 设置粗体格式，中文使用伪粗体代替真粗体
#let set_cn_bold(doc) = {
  show: show-cn-fakebold
  doc
}

// 设置各级标题格式
#let set_doc_heading(doc, continuous_index: false) = {
  // 章标题（没有supplement）
  show heading.where(level: 1): set heading(supplement: none)
  show heading.where(level: 1): it => {
    pagebreak()
    set align(center)
    set text(size: 字号.三号, font: 字体.黑体, weight: "bold")
    v(-0.5em)
    it
    text(v(0em, weak: true))
    text(h(0em))
    v(0.2em)

    if not continuous_index {
      // 用于解决公式跨章节连续编号的问题
      counter(math.equation).update(0)
    }
  }
  // 节标题
  show heading.where(level: 2): it => {
    set text(size: 字号.四号, font: 字体.黑体, weight: "regular")
    it
    text(v(0em, weak: true))
    text(h(0em))
    v(0.2em)
  }
  // 小节标题
  show heading.where(level: 3): it => {
    set text(size: 字号.小四, font: 字体.宋体)
    it
    text(v(0em, weak: true))
    text(h(0em))
    v(0em)
  }

  set heading(numbering: (..nums) => {
    let nums_array = nums.pos()
    if nums_array.len() == 1 {
      // 章标题样式：第一章
      "第" + int-to-cn-num(nums_array.first()) + "章"
    } else {
      // 节标题样式: 1.1, 1.1.1
      text(weight: "regular", numbering("1.1", ..nums))
    }
  })
  doc
}

// 设置正文基本格式
#let set_doc_basic(doc) = {
  set text(size: 字号.小四, font: 字体.宋体, lang: "zh", region: "cn")
  set page(
    paper: "a4",
    header: [
      #set text(9pt, weight: "regular")
      #set align(center)
      东南大学本科毕业设计（论文）
      #place(line(length: 100%, stroke: 0.7pt), dy: 5pt)
      #counter(footnote).update(0) // 脚注序号以页为单位
    ],
    numbering: (..idx) => {
      text(size: 9pt, numbering("1", idx.pos().first()))
    },
    margin: (top: 3cm, x: 2.5cm, bottom: 3.8cm),
  )

  // 重置页码
  counter(page).update(1)

  // 1.5倍行距，两端对齐，首行缩进
  set par(leading: 行距, justify: true, first-line-indent: 2em)
  show par: set block(spacing: 行距)

  // 粗体样式
  show strong: text.with(font: 字体.宋体, weight: "bold")

  doc
}

#let set_doc_figure(doc, continuous_index: false) = {
  // 子图使用(a)编号，图编号样式:2-1，表样式:2.1。可选择全文连续编号
  let figure_numbering(idx, kind: none, loc: auto) = {
    if kind == "subfigure" {
      return numbering("(a)", idx)
    }
    let separator = if kind == image {
      "-"
    } else {
      "."
    }
    let chapter_idx = get_chapter_idx_display(loc: loc)
    if continuous_index {
      idx
    } else {
      [#chapter_idx#separator#idx]
    }
  }
  // 设置标题样式、间距
  show figure.caption: it => {
    set text(size: 10.5pt)

    block(
      inset: (left: 2em, right: 2em),
      {
        set align(left)
        if it.kind == table {
          v(1em)
        }
        it.supplement
        it.counter.display(figure_numbering.with(kind: it.kind))
        h(0.5em)
        it.body
      },
    )
  }
  show figure.where(kind: table): set text(size: 字号.五号)
  show figure.where(kind: table): set figure.caption(position: top)

  // 图表上下间隔1.5em
  set figure(gap: 1.5em)

  // 每章重置图表编号
  show heading.where(level: 1): it => {
    if not continuous_index {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: raw)).update(0)
    }
    it
  }

  // 每张大图中，子图重置编号
  show figure: it => {
    if it.kind != "subfigure" {
      counter(figure.where(kind: "subfigure")).update(0)
    }
    it
    text()[#v(0em, weak: true)#h(0em)]
  }

  // 设置交叉引用样式
  show ref: it => {
    let el = it.element
    if el == none {
      // 不是图
      return it
    }
    let el_loc = el.location()
    if el.func() == figure {
      if el.kind == "subfigure" {
        // 获得所在大图
        let parent_fig = query(figure.where(kind: image).before(el_loc)).last()
        // 获得大图序号
        let parent_fig_idx = parent_fig.counter.at(el_loc).first()
        // 获得章节序号
        let chapter_idx = get_chapter_idx_display(loc: el_loc)
        // 子图引用格式:图2-1(a)
        link(el_loc)[图#{chapter_idx}-#parent_fig_idx~(#it)]
      } else {
        let supplement = if el.kind == image {
          "图"
        } else {
          "表"
        }
        link(
          el.location(),
          {
            supplement
            // 图表引用格式同caption格式
            figure_numbering(..el.counter.at(el_loc), kind: el.kind, loc: el_loc)
          },
        )
      }
    } else if el.func() == math.equation {
      if continuous_index {
        it
      } else {
        link(
          el.location(),
          {
            "公式 ("
            get_chapter_idx_display(loc: el_loc)
            "."
            str(counter(math.equation).at(el_loc).first())
            ")"
          },
        )

      }
    } else {
      it
    }
  }

  doc
}

// 设置公式格式
#let set_doc_math(doc, continuous_index: false) = {
  set math.equation(numbering: idx => {
    if not continuous_index {
      // 按章节编号
      let chapter_idx = get_chapter_idx_display()
      [(#chapter_idx.#idx)]
    } else {
      [(#idx)]
    }
  })
  doc
}

// 统一设置正文格式
#let set_doc(doc, continuous_index: false) = {
  let doc = set_doc_basic(doc)
  let doc = set_doc_heading(doc, continuous_index: continuous_index)
  let doc = set_cn_bold(doc)

  let doc = set_doc_figure(doc, continuous_index: continuous_index)
  let doc = set_doc_math(doc, continuous_index: continuous_index)

  return doc
}
