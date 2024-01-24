# SEU-Thesis-Typst

东南大学Typst论文模板库。
![SEU-Thesis-Typst](./figures/preview.png)

[点击查看完整PDF样本](./bachelor_thesis.pdf)

# 什么是Typst？

[Typst](https://typst.app/)是一种全新的现代化排版语言，语法简洁堪比Markdown，功能强大堪比Latex，更有众多优秀的特性，例如毫秒级实时编译预览。下表是Word、Markdown、Latex、Typst一些方面的对比。

|    | Word | Markdown | Latex | Typst |
| :--- | :---:  | :---: | :---: | :---: |
| 程序体量 | 大 | 小 | 极大 | 小 |
| 排版自由度 | 高 | 低 | 高 | 高 |
| 排版稳定性 | 中 | 高 | 高 | 高 |
| 使用难度 | 中 | 低 | 高 | 较低 |
| 可编程性 | 无 | 无 | 中 | 高 |
| 可拓展性 | 低 | 无 | 高 | 高 |
| 实时渲染 | √ | √ | × | √ |
| 多人协作 | - | × | √ | √ |

# 如何使用
## 网页编辑器
进入[Typst官方网页编辑器](https://typst.app/)，新建项目，导入本仓库所有文件，编辑模板。

## 本地编辑
克隆本仓库。按照Typst[官方仓库](https://github.com/typst/typst)说明，安装Typst，从fonts文件夹中安装缺失字体。编辑模板并编译生成。

推荐使用VSCode及Typst LSP插件，可以获得与网页编辑器类似的体验。

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
- 本仓库模板基于Typst 0.10版本编写，请确保所使用的Typst版本一致。后续会随Typst版本迭代更新模板。

- 本仓库模板已尽力复刻学校提供的Word模板，但是在一些细节上（页边距、行距、标题间距等）与Word模板仍有一些肉眼难以分辨的细微差距。我们欢迎使用者向本仓库提出PR，完善模板。

- Typst目前暂不支持插入PDF。矢量图请保存为SVG格式，或将PDF转为SVG。

# 参考项目
 - [PKUTHSS-Typst](https://github.com/lucifer1004/pkuthss-typst)