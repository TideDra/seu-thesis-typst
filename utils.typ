#import "constants.typ":字体,字号,行距
#import "@preview/a2c-nums:0.0.1": int-to-cn-num
#import "@preview/tablex:0.0.8": tablex,vlinex,hlinex,colspanx,rowspanx
#let midhline = hlinex(stroke:0.7pt)
#let midvline = vlinex(stroke:0.5pt)

#let part_state = state("part")

//使用terms模拟latex的paragraph
#let paragraph(content) = {
  set terms(hanging-indent: 0pt,indent:0pt)
  set par(first-line-indent: 0pt)
  content
  [#v(-18pt)\ ]
}

//获取当前章节序号
#let get_chapter_idx(loc:none) = locate(cur_loc => {
  if loc == none{
    return counter(heading).at(cur_loc).first()
  }
  else{
    return counter(heading).at(loc).first()
  }
})

//获取用于显示的章节序号 
#let get_chapter_idx_display(loc: none) = locate(cur_loc => {
  let loc = if loc != none {loc} else {cur_loc}
  let chapter_idx = counter(heading).at(loc).first()
  let is_appendix = if part_state.at(loc) == "appendix" {true} else {false}

  return numbering(if is_appendix {"A"} else {"1"}, chapter_idx)
})

//使用typst的画圈功能实现带圈数字
#let my_circle_number(num,size,inset:0pt,stroke:0.5pt) = {
    set text(size:size)
    let circle_size = size/2
   box[#circle(radius: circle_size,inset: inset,stroke: stroke)[#set align(center)
   #num]]
  }

//使用unicode带圈数字
#let circle_number(num) = {
  // only support 0~50
  if num==0{
    return str.from-unicode(9450)
  }
  if 1<=num and num<=20{
    return str.from-unicode(9311+num)
  }
  if 21<=num and num<=35{
    return str.from-unicode(12860+num)
  }
  if 36<=num and num<=50{
    return str.from-unicode(12941+num)
  }
}

//子图
#let subfigure = figure.with(
  kind:"subfigure",
  supplement:none,
  numbering:"(a)"
)

//设置脚注格式。该函数必须在文档开头调用。
#let set_doc_footnote(doc) = {
  set footnote(numbering: (..nums)=>{
    set text(size:6pt,baseline: -4.5pt)
    circle_number(nums.pos().first())
  }) //使用带圈数字

  show footnote.entry: it => {
  let loc = it.note.location()
  let idx = counter(footnote).at(loc).first()
  if idx ==1 {v(6pt)}
  h(-0.5em)
  text(size:4.5pt,baseline:-3.1pt, circle_number(idx))
  h(3pt)
  text(size: 9pt,font:字体.宋体,it.note.body)
} //自定义脚注项，调整字号、间距
  doc
}

//设置各级标题格式
#let set_doc_heading(doc, continuous_index: false) = {
  //章标题
  show heading.where(level:1):it=>{
    pagebreak()
    set align(center)
    set text(size:字号.三号,font:字体.黑体,weight:"bold")
    v(-0.5em)
    it
    text()[#v(0em, weak: true)]
    text()[#h(0em)]
    v(0.2em)

    if not continuous_index {
      counter(math.equation).update(0)
      // 用于解决公式跨章节连续编号的问题
    }
  }
  //节标题
  show heading.where(level:2):it=>{
    set text(size:字号.四号,font:字体.黑体,weight: "regular")
    it
    text()[#v(0em, weak: true)]
    text()[#h(0em)]
    v(0.2em)
  }
  //小节标题
  show heading.where(level:3):it=>{
    set text(size:字号.小四,font:字体.宋体)
    it
  }
  
  set heading(numbering: (..nums)=>{
    let nums_array = nums.pos()
    if nums_array.len()==1{
      "第"+int-to-cn-num(nums_array.first())+"章" //章标题样式：第一章
    }
    else{
      text(weight: "regular",numbering("1.1",..nums)) //节标题样式: 1.1, 1.1.1
    }
  })
  doc
}

//设置正文基本格式
#let set_doc_basic(doc) = {
  set text(size: 字号.小四,font:字体.宋体,lang: "zh", region: "cn")
  set page(paper: "a4",
           header: [
           #set text(9pt)
           #set align(center)
           东南大学本科毕业设计（论文）
           #place(line(length:100%,stroke:0.7pt),dy:5pt)
           #counter(footnote).update(0) //脚注序号以页为单位
           ],
            numbering: (..idx)=>{text(size:9pt,numbering("1",idx.pos().first()))}, //设置页码样式
            margin:(top:3cm,x:2.5cm,bottom:3.8cm) //页边距
          )

  counter(page).update(1) //重置页码
  set par(leading: 行距,justify: true,first-line-indent: 2em) //1.5倍行距，两端对齐，首行缩进
  show par: set block(spacing: 行距)
  
  show strong: it=>text(font: 字体.Noto宋体,weight: "bold")[#it] //粗体样式。 SimSun没有粗体，这里使用Noto Serif SC Bold作为宋体粗体
  doc
}


#let set_doc_figure(doc,continuous_index:false) = {

  //子图使用(a)编号，图编号样式:2-1，表样式:2.1。可选择全文连续编号
  let figure_numbering(idx,kind:none,loc:none) = {
    if kind=="subfigure"{
      return numbering("(a)",idx)
    }
    let separator = if kind==image{"-"} else{"."}
    let chapter_idx = get_chapter_idx_display(loc: loc)
    if not continuous_index{
      return [#{chapter_idx}#separator#idx]
    }
    else{
      return idx
    }
  }
  //设置标题样式、间距
  show figure.caption:it=>{
    set text(size:10.5pt)

    block(inset:(left:2em,right:2em))[
      #set align(left)
      #if it.kind==table {v(1em)}
      #it.supplement #it.counter.display(figure_numbering.with(kind:it.kind))#h(0.5em)
      #it.body
    ]
  }
  show figure.where(kind:table): set text(size:字号.五号)
  show figure.where(kind:table): set figure.caption(position: top)


  set figure(
      gap:1.5em,
  ) //图表上下间隔1.5em
  
  show heading.where(level:1):it=>{
    if not continuous_index{
      counter(figure.where(kind:image)).update(0)
      counter(figure.where(kind:table)).update(0)
      counter(figure.where(kind:raw)).update(0)
    }
    it
  }//每章重置图表编号
  
  show figure:it=>{
    if it.kind != "subfigure"{
      counter(figure.where(kind:"subfigure")).update(0)
    }
    it
    text()[#v(0em, weak: true)#h(0em)]
  }//每张大图中，子图重置编号

  //设置交叉引用样式
  show ref: it=>{
    let el = it.element
    if el != none and el.func()==figure and el.kind == "subfigure"{
      let subfig_loc = el.location()
      locate(loc=>{
        let parent_fig = query(figure.where(kind:image).before(subfig_loc),loc).last() //获得所在大图
        let parent_fig_idx = parent_fig.counter.at(subfig_loc).first() //获得大图序号
        let chapter_idx = get_chapter_idx_display(loc:subfig_loc) //获得章节序号
        return link(subfig_loc)[图#{chapter_idx}-#{parent_fig_idx}~(#it)] //子图引用格式:图2-1(a)
      })
    }
    else{
      if el!=none and el.func()==figure{
        let supplement = if el.kind==image{"图"} else{"表"}
        return link(el.location(),locate(loc=>{
          supplement
          if continuous_index {
            str(
              figure_numbering(..el.counter.at(el.location()),kind:el.kind,loc:el.location()) //图表引用格式同caption格式
            )
          } else {
            figure_numbering(..el.counter.at(el.location()),kind:el.kind,loc:el.location())
          }
        }))
      }
      else if el!=none and el.func() == math.equation {
        if continuous_index {
          return it
        } else {
          "公式 ("
          get_chapter_idx_display(loc: el.location())
          "."
          str(counter(math.equation).at(el.location()).first())
          ")"
        }
      } else {
        return it
      }
    }
  }

  doc
}

//设置公式格式
#let set_doc_math(doc,continuous_index:false) = {

  set math.equation(numbering: idx=>{
    let chapter_idx = get_chapter_idx_display()
    if not continuous_index{
      return [(#{chapter_idx}.#idx)] //按章节编号
    }
    else{
      return [(#idx)]
    }
  })
  doc
}

//统一设置正文格式
#let set_doc(doc,continuous_index:false) = {
  let doc = set_doc_basic(doc)
  let doc = set_doc_heading(doc, continuous_index:continuous_index)
  
  let doc = set_doc_figure(doc,continuous_index:continuous_index)
  let doc = set_doc_math(doc,continuous_index:continuous_index)

  return doc
}