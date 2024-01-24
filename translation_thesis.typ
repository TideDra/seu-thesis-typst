#import "template.typ": translation_conf
#import "utils.typ": set_doc_footnote
#show :doc => set_doc_footnote(doc)   //由于Typst目前的缺陷，footnote必须在开头设置。未来可能会改进。
#let info = (
  raw_paper_name:"Name of Raw Paper",
  translated_paper_name:"论文中文标题",
  student_id:"123456",
  name:"张三",
  college:"霍格沃兹学院",
  major:"母猪产后护理",
  supervisor:"指导老师",
  abstract:[此处编写中文摘要],
  key_words:("关键词1","关键词2"),
)
#show :doc => translation_conf(
  doc,
  ..info
) //对以下文本应用模板

= 绪论
此处编写正文
