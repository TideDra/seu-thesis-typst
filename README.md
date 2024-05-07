# SEU-Thesis-Typst

东南大学 Typst 论文模板库。
![SEU-Thesis-Typst](./figures/preview.png)

[点击查看完整 PDF 样本](./bachelor_thesis.pdf)

# 什么是 Typst？

[Typst](https://typst.app/)是一种全新的现代化排版语言，语法简洁堪比 Markdown，功能强大堪比 Latex，更有众多优秀的特性，例如毫秒级实时编译预览。下表是 Word、Markdown、Latex、Typst 一些方面的对比。

|            | Word | Markdown | Latex | Typst |
| :--------- | :--: | :------: | :---: | :---: |
| 程序体量   |  大  |    小    | 极大  |  小   |
| 排版自由度 |  高  |    低    |  高   |  高   |
| 排版稳定性 |  中  |    高    |  高   |  高   |
| 使用难度   |  中  |    低    |  高   | 较低  |
| 可编程性   |  无  |    无    |  中   |  高   |
| 可拓展性   |  低  |    无    |  高   |  高   |
| 实时渲染   |  √   |    √     |   ×   |   √   |
| 多人协作   |  -   |    ×     |   √   |   √   |

# 如何使用

## 网页编辑器

进入[Typst 官方网页编辑器](https://typst.app/)，新建项目，导入本仓库所有文件，编辑模板。

## 本地编辑

克隆本仓库。按照 Typst[官方仓库](https://github.com/typst/typst)说明，安装 Typst，从 fonts 文件夹中安装缺失字体。编辑模板并编译生成。

推荐使用 VSCode 及 Typst LSP 插件，可以获得与网页编辑器类似的体验。

# 模板列表

- `bachelor_thesis.typ`: 本科毕设论文
- `translation_thesis.typ`: 本科毕设文献翻译

欢迎向本仓库贡献更多模板！

# 模板样例

```typst
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

= 绪论 //章标题
== 引言 //节标题
此处编写正文
```

# 注意事项

- 本仓库模板基于 Typst 0.11 版本编写，请确保所使用的 Typst 版本一致。后续会随 Typst 版本迭代更新模板。

- 本仓库模板已尽力复刻学校提供的 Word 模板，但是在一些细节上（页边距、行距、标题间距等）与 Word 模板仍有一些肉眼难以分辨的细微差距。**因使用本模板造成的各种后果请自行承担**。我们欢迎使用者向本仓库提出 PR，完善模板。

- 模板还在不断完善中，在使用过程中请及时拉取本仓库最新代码。

- Typst 目前暂不支持插入 PDF。矢量图请保存为 SVG 格式，或将 PDF 转为 SVG。

- 本科毕设模板目前采用[SEU-Typst-Template](https://github.com/csimide/SEU-Typst-Template)提供的`gb-t-7714-2015-numeric-seu-bachelor.csl`作为参考文献格式。该格式已尽量复刻官方Word模板中的格式，但仍有差异。详情请移步至原项目仓库查看。

# 参考项目

- [PKUTHSS-Typst](https://github.com/lucifer1004/pkuthss-typst)

# 相关项目

- [SEU-Typst-Template](https://github.com/csimide/SEU-Typst-Template) 提供了更多学位论文模板
