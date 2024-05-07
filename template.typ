#import "constants.typ": 字体, 字号, 行距
#import "utils.typ": set_doc, set_doc_footnote, part_state
#import "@preview/cuti:0.2.0": show-cn-fakebold

// 论文翻译封面
#let translation_cover(
  raw_paper_name: none,
  translated_paper_name: none,
  student_id: none,
  name: none,
  college: none,
  major: none,
  supervisor: none,
  date: datetime.today().display("[year].[month].[day]"),
) = {
  set page(paper: "a4")
  set text(font: 字体.宋体, lang: "zh", region: "cn")

  align(center)[
    #image("figures/logo.png", width: 45%)
    #v(-1em)
    #text(size: 26pt, font: 字体.黑体)[*本科毕业设计（论文）资料翻译*]
  ]
  v(24pt)
  align(right)[
    #block(width: 90%, height: 8cm)[
      #set align(left)
      #set par(leading: 2em)
      #text(size: 16pt)[翻译资料名称（外文）\ #raw_paper_name]\
      #text(size: 16pt)[翻译资料名称（中文）\ #translated_paper_name]
    ]
  ]

  align(center)[
    #set par(leading: 18pt)
    #let info_row(
      key,
      value,
    ) = [#key:#h(2.5em)#box(width: 58%, stroke: (bottom: black), outset: 4pt)[#align(center)[#value]]]
    #set text(size: 18pt)
    #block(width: 80%)[
      #info_row([学#h(2em)号], [#student_id])\
      #info_row([姓#h(2em)名], [#name])\
      #info_row([学#h(2em)院], [#college])\
      #info_row([专#h(2em)业], [#major])\
      #info_row([指导教师], [#supervisor])\
      #info_row([完成日期], [#date])
    ]
  ]
}

// 本科毕设封面
#let bachelor_cover(
  title: none,
  student_id: none,
  name: none,
  college: none,
  major: none,
  supervisor: none,
  duration: none,
) = {
  set page(paper: "a4", margin: (right: 2.4cm, left: 2.4cm, top: 2cm, bottom: 2cm))

  show: show-cn-fakebold

  set align(center)
  v(1.2cm)
  image("figures/logo.png", width: 10cm)
  v(-0.53cm)
  text(font: 字体.黑体, size: 字号.一号, weight: "bold")[本科毕业设计（论文）报告]
  v(2.07cm)

  let title_array() = {
    if type(title)!=array {return (title,)}
    else {return title}
  }
  set text(font: 字体.黑体, size: 22pt)
  let underline_entire_line(doc) = {
    box(width:100%,stroke: (bottom: 0.5pt), outset: (bottom: 6pt, x: 8pt),underline(stroke: 0.5pt,offset: 6pt,extent:8pt)[#doc])
  }
  grid(
    columns: (2.2cm, 1fr),
    gutter: 18pt,
    [题#h(0.5em)目: ],
    par(leading: 30pt,title_array().map(underline_entire_line).join())
  )
  v(1.8cm)
  set par(justify: true)
  set text(font: 字体.宋体, size: 18pt)

  grid(
    columns: (1.4cm, 5em, 1fr, 1.8cm),
    column-gutter: 12pt,
    row-gutter: 1.5em,
    [],
    [学#h(2em)号：],
    [#box(stroke: (bottom: 0.5pt), outset: 6pt, width: 100%, student_id)],
    [],
    [],
    [姓#h(2em)名：],
    [#box(stroke: (bottom: 0.5pt), outset: 6pt, width: 100%, name)],
    [],
    [],
    [学#h(2em)院：],
    [#box(stroke: (bottom: 0.5pt), outset: 6pt, width: 100%, college)],
    [],
    [],
    [专#h(2em)业：],
    [#box(stroke: (bottom: 0.5pt), outset: 6pt, width: 100%, major)],
    [],
    [],
    [指导教师：],
    [#box(stroke: (bottom: 0.5pt), outset: 6pt, width: 100%, supervisor)],
    [],
    [],
    [起止日期：],
    [#box(stroke: (bottom: 0.5pt), outset: 6pt, width: 100%, duration)],
    [],
  )
}

// 论文声明页
#let claim_page() = {
  set page(paper: "a4", margin: (x: 2.3cm, top: 2cm, bottom: 2cm))
  set align(center)
  v(1.7cm)
  text(font: 字体.黑体, size: 18pt)[东南大学毕业（设计）论文独创性声明]
  v(0.8cm)
  set align(left)
  set par(first-line-indent: 2em, justify: true, leading: 行距)
  set text(font: 字体.宋体, size: 12pt)
  [本人声明所呈交的毕业（设计）论文是我个人在导师指导下进行的研究工作及取得的研究成果。尽我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得东南大学或其它教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示了谢意。]
  par()[#v(1em)]
  [#h(2em)论文作者签名：#box(width: 8em, stroke: (bottom: 0.5pt), outset: 2pt)#h(1.5em)日期：#box(width: 3.5em, stroke: (bottom: 0.5pt), outset: 2pt)年#box(width: 2.5em, stroke: (bottom: 0.5pt), outset: 2pt)月#box(width: 2.5em, stroke: (bottom: 0.5pt), outset: 2pt)日]

  v(3.5cm)
  set align(center)
  v(1.3cm)
  text(font: 字体.黑体, size: 18pt)[东南大学毕业（设计）论文使用授权声明]
  v(0.5cm)
  set align(left)
  set par(first-line-indent: 2em, justify: true, leading: 行距)
  set text(font: 字体.宋体, size: 12pt)
  [东南大学有权保留本人所送交毕业（设计）论文的复印件和电子文档，可以采用影印、缩印或其他复制手段保存论文。本人电子文档的内容和纸质论文的内容相一致。除在保密期内的保密论文外，允许论文被查阅和借阅，可以公布（包括刊登）论文的全部或部分内容。论文的公布（包括刊登）授权东南大学教务处办理。]

  par()[#v(1em)]
  [论文作者签名：#box(width: 9.5em, stroke: (bottom: 0.5pt), outset: 2pt)#h(2em)导师签名：#box(width: 11.5em, stroke: (bottom: 0.5pt), outset: 2pt)#h(1.5em)\
    #h(2em)日期：#box(width: 3.5em, stroke: (bottom: 0.5pt), outset: 2pt)年#box(width: 2.5em, stroke: (bottom: 0.5pt), outset: 2pt)月#box(width: 2.5em, stroke: (bottom: 0.5pt), outset: 2pt)日#h(4em)日期：#box(width: 3.5em, stroke: (bottom: 0.5pt), outset: 2pt)年#box(width: 2.5em, stroke: (bottom: 0.5pt), outset: 2pt)月#box(width: 2.5em, stroke: (bottom: 0.5pt), outset: 2pt)日]
}

// 中文摘要页
#let zh_abstract_page(abstract, key_words) = {
  pagebreak()
  set page(
    paper: "a4",
    margin: (top: 3cm, x: 2.5cm, bottom: 3.8cm),
  )
  set text(size: 12pt, font: 字体.宋体, lang: "zh", region: "cn")
  show heading.where(level: 1): it => {
    set align(center)
    set text(size: 16pt, font: 字体.黑体, weight: "bold")
    it
    par()[#text(size: 0.5em)[#h(0.0em)]]
    v(0.2em)
  }
  show: show-cn-fakebold
  set heading(numbering: none)
  [= 摘#h(2em)要]

  set text(size: 12pt)
  set par(first-line-indent: 2em, justify: true, leading: 行距)
  show par: set block(spacing: 行距)
  abstract

  v(1em)
  set par(first-line-indent: 0em)
  "关键词：" + key_words.join("，")
}

// 英文摘要页
#let en_abstract_page(abstract, key_words) = {
  pagebreak()
  set page(
    paper: "a4",
    margin: (top: 2.55cm, x: 2.5cm, bottom: 3.8cm),
  )
  show heading.where(level: 1): it => {
    set align(center)
    set text(size: 16pt, font: 字体.黑体, weight: "bold")
    it
    par()[#text(size: 0.5em)[#h(0.0em)]]
    v(0.2em)
  }
  show: show-cn-fakebold
  set heading(numbering: none)
  [= ABSTRACT]

  set text(size: 字号.小四, font: 字体.宋体)
  set par(first-line-indent: 2em, justify: true, leading: 行距)
  show par: set block(spacing: 行距)
  abstract

  v(2em)
  "KEY WORDS: " + key_words.join(", ")
}

// 目录页
#let outline_page() = {
  pagebreak()
  set page(
    paper: "a4",
    margin: (top: 2.6cm, x: 2.5cm, bottom: 3.8cm),
  )
  set text(size: 12pt, font: 字体.宋体, lang: "zh", region: "cn")
  set par(leading: 12pt, justify: true)
  show heading.where(level: 1): it => {
    set align(center)
    set text(size: 16pt, font: 字体.黑体, weight: "bold")
    it
  }
  show: show-cn-fakebold
  show outline.entry: it => {
    link(it.element.location())[
      #set text(size: 字号.小四)
      #it.body
      #box(width: 1fr, repeat[.])
      #it.page.at("child")
    ]
  }
  heading(level: 1, bookmarked: true, outlined: true)[目#h(2em)录]
  v(0.6em)
  outline(
    title: none,
    indent: 2em,
    depth: 3,
  )
  set par(first-line-indent: 2em)
}

// 参考文献页
#let seu_bibliography(bib_file: "reference.bib") = {
  set text(size: 字号.五号, font: 字体.宋体, lang: "en")
  set par(justify: true)

  bibliography(bib_file, style: "gb-t-7714-2015-numeric-seu-bachelor.csl", title: [参考文献])
}

#let appendix(doc) = {
  counter(heading).update(0)
  part_state.update("appendix")
  set heading(numbering: (..nums) => {
    let nums_array = nums.pos()
    if nums_array.len() == 1 {
      "附录" + numbering("A", nums_array.first()) + " "
    } else {
      numbering("A.1", ..nums)
    }
  })
  doc
}

// 致谢页
#let acknowledgment(doc) = {
  set heading(numbering: none)
  [= 致#h(2em)谢]
  doc
}

// 论文翻译模板
#let translation_conf(
  raw_paper_name: none,
  translated_paper_name: none,
  student_id: none,
  name: none,
  college: none,
  major: none,
  supervisor: none,
  date: datetime.today().display("[year].[month].[day]"),
  abstract: none,
  key_words: (),
  doc,
) = {
  translation_cover(
    raw_paper_name: raw_paper_name,
    translated_paper_name: translated_paper_name,
    student_id: student_id,
    name: name,
    college: college,
    major: major,
    supervisor: supervisor,
    date: date,
  )

  // numbering setting must be before update()
  set page(numbering: (..idx) => {
    text(size: 9pt, numbering("I", idx.pos().first()))
  })

  counter(page).update(1)

  zh_abstract_page(abstract, key_words)

  outline_page()

  set_doc(doc)
}

// 本科毕设模板
#let bachelor_conf(
  title: none,
  student_id: none,
  name: none,
  college: none,
  major: none,
  supervisor: none,
  duration: none,
  zh_abstract: none,
  zh_key_words: (),
  en_abstract: none,
  en_key_words: (),
  continuous_index: false,
  doc,
) = {
  bachelor_cover(
    title: title,
    student_id: student_id,
    name: name,
    college: college,
    major: major,
    supervisor: supervisor,
    duration: duration,
  )

  claim_page()

  // numbering setting must be before update()。正文前用罗马数字编号。
  set page(numbering: (..idx) => {
    text(size: 9pt, numbering("I", idx.pos().first()))
  })

  counter(page).update(1)

  zh_abstract_page(zh_abstract, zh_key_words)
  en_abstract_page(en_abstract, en_key_words)
  outline_page()

  set_doc(doc, continuous_index: continuous_index)
}
