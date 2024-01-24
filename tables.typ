#import "@preview/tablex:0.0.8": tablex,vlinex,hlinex,colspanx,rowspanx
#let midhline = hlinex(stroke:0.7pt)
#let midvline = vlinex(stroke:0.5pt)
#let _mmbench_eval={
  tablex(
    auto-lines:false,
    columns:9,
    stroke:1pt,
    map-cells:cell=>{
      v(-1pt)
      [#cell.content]
      v(-1pt)
    },
    align:(x,y)=>{
      if x==0{
        left+horizon
      }
      else{
        center+horizon
      }
    },
    hlinex(),
    [*LLM*],[*Data*],[*Overall*],[*LR*],[*AR*],[*RR*],[*FP-S*],[*FP-C*],[*CP*],
    midhline,
    [OpenFlamingo#text(baseline: 2pt,size:9pt)[9B]],[-],[6.6],[4.2],[15.4],[0.9],[8.1],[1.4],[5.0],
    [MiniGPT-4#text(baseline: 2pt,size:9pt)[7B]],[5k], [24.3], [7.5], [31.3], [4.3], [30.3], [9.0], [35.6], 
    [LLaMA-Adapter#text(baseline: 2pt,size:9pt)[7B]], [52k], [41.2], [11.7], [35.3], [29.6], [47.5], [38.6], [56.4], 
    [Otter-I#text(baseline: 2pt,size:9pt)[9B]], [2.8M], [51.4], [32.5], [56.7], [53.9], [46.8], [38.6], [65.4], 
    [Shikra#text(baseline: 2pt,size:9pt)[7B]], [5.5M],[58.8], [25.8],[56.7], [*58.3*], [57.2], [*57.9*], [*75.8*], 
    [Kosmos-2], [14M], [59.2], [*46.7*], [55.7], [43.5], [64.3], [49.0], [72.5], 
    [InstructBLIP#text(baseline: 2pt,size:9pt)[7B]],[1.2M], [36.0], [14.2], [46.3], [22.6], [37.0], [21.4], [49.0],
    [IDEFICS#text(baseline: 2pt,size:9pt)[9B]], [1M], [48.2], [20.8], [54.2], [33.0], [47.8], [36.6], [67.1], 
    [IDEFICS#text(baseline: 2pt,size:9pt)[80B]], [1M],[54.6], [29.0], [*67.8*], [46.5], [56.0], [48.0], [61.9],
    [InstructBLIP#text(baseline: 2pt,size:9pt)[13B]], [1.2M], [44.0], [19.1], [54.2], [34.8], [47.8], [24.8], [56.4],
    midhline,
    [LLaVA#text(baseline: 2pt,size:9pt)[7B]], [158k], [38.7], [16.7], [48.3], [30.4], [45.5], [32.4], [40.6],
    [*LLaVA-SFT#text(baseline: -4pt)[+]#text(baseline: 2pt,size:9pt)[7B]*], [220k], [52.1], [28.3], [63.2], [37.4], [53.2], [35.9], [66.8],
    [*LLaVA-RLHF#text(baseline: 2pt,size:9pt)[7B]*], [280k], [51.4] ,[24.2], [63.2], [39.1], [50.2], [40.0], [66.1],
    [LLaVA#text(baseline: 2pt,size:9pt)[13B×336]], [158k], [47.5], [23.3], [59.7], [31.3], [41.4], [38.6], [65.8],
    [*LLaVA-SFT#text(baseline: -4pt)[+]#text(baseline: 2pt,size:9pt)[13B×336]*], [220k], [57.5], [25.8], [65.7], [54.8] ,[57.9], [51.0], [68.5],
    [*LLaVA-RLHF#text(baseline: 2pt,size:9pt)[13B×336]*], [280k], [*60.1*], [29.2], [67.2],[56.5], [*60.9*] ,[53.8], [71.5],
    hlinex()
  )
}

#let _pope_eval={
  set text(size:10pt)
    tablex(
    auto-lines:false,
    columns:12,
    stroke:1pt,
    align:(x,y)=>{
      if x==0{
        left+horizon
      }
      else{
        center+horizon
      }
    },
    hlinex(),
    rowspanx(2)[*Model*],midvline,colspanx(3)[*Random*],midvline,(),colspanx(3)[*Popular*],midvline,(),colspanx(3)[*Adversarial*],midvline,(),colspanx(2)[*Overall*],
    (),[*Acc$arrow.t$*],[*F1$arrow.t$*],[*Yes(%)*],[*Acc$arrow.t$*],[*F1$arrow.t$*],[*Yes(%)*],[*Acc$arrow.t$*],[*F1$arrow.t$*],[*Yes(%)*],[*F1$arrow.t$*],[*Yes(%)*],
    midhline,
    [Shikra],[86.9],[86.2],[43.3],[84.0],[83.2],[45.2],[83.1],[82.5],[46.5],[84.0],[45.0],[InstructBLIP∗7B],[88.6],[89.3],[56.6],[79.7],[80.2],[52.5],[65.2],[70.4],[67.8],[80.0],[59.0],[MiniGPT-4∗7B],[79.7],[80.2],[52.5],[69.7],[73.0],[62.2],[65.2],[70.4],[67.8],[74.5],[60.8],[mPLUG-Owl∗7B],[54.0],[68.4],[95.6],[50.9],[66.9],[98.6],[50.7],[66.8],[98.7],[67.2],[97.6],[LLaVA∗7B],[50.4],[66.6],[98.8],[49.9],[66.4],[99.4],[49.7],[66.3],[99.4],[66.4],[99.2],[LLaVA7B],[76.3],[80.7],[70.9],[68.4],[75.3],[77.9],[62.7],[72.0],[83.2],[76.0],[77.3],[LLaVA-SFT+7B],[86.1],[85.5],[44.5],[82.9],[82.4],[47.2],[80.2],[80.1],[49.6],[82.7],[47.1],[LLaVA-RLHF7B],[84.8],[83.3],[39.6],[83.3],[81.8],[41.8],[80.7],[79.5],[44.0],[81.5],[41.8],[LLaVA13B],[73.7],[78.8],[72.3],[73.6],[78.2],[71.0],[67.2],[74.4],[77.8],[77.1],[73.7],[LLaVA-SFT+13B],[86.0],[84.8],[40.5],[84.0],[82.6],[41.6],[82.3],[81.1],[43.5],[82.8],[41.9],[LLaVA-RLHF13B],[85.2],[83.5],[38.4],[83.9],[81.8],[38.0],[82.3],[80.5],[40.5],[81.9],[39.0],
    hlinex()
  )
}

#let mmbench_eval=[#figure(
  _mmbench_eval,
  caption: [MMBench dev集上循环评测多选题准确率结果。我们采用以下简称：LR为逻辑推理；AR为属性推理；RR为关系推理；FP-C为细粒度感知（交叉实例）；FP-S为细粒度感知（单实例）；CP为粗粒度感知；基线结果源自#cite(<liu2023llava>,form:"author",style:"spie")#text(size:0pt)[1]@liu2023llava。],
  kind:table,
)<tab:mmbench_eval>]

#let pope_eval=[#figure(
  _pope_eval,
  caption:[POPE基准测试@li2023otter。Acc代表预测的准确率。"Yes"代表模型输出正答案的概率。"\*"标记的结果引用自@li2023otter。],
  kind:table
)<tab:pope_eval>]

#let preference_collection=[#figure(
block(width: 100%,breakable: false,fill: luma(238),stroke: 1pt,radius: 5pt,inset:(top:1em,left:2em,right:2em,bottom:1em))[
  #set par(leading: 0.5em,first-line-indent: 0em)
  #set text(size:10pt)
  #set align(left)
  *Instruction*
  
  We have developed an AI assistant adept at facilitating image-based conversations. However, it occasionally generates what we call hallucinations, which are inaccuracies unsupported by the image content or real-world knowledge. In this task, we request that you select the most appropriate response from the AI model based on the conversation context. When making this selection, primarily consider these two factors: 
  - *Honesty*: Fundamentally, the AI should provide accurate information and articulate its uncertainty without misleading the user. If one response includes hallucination and the other doesn’t, or if both responses contain hallucinations but one does to a greater extent, you should opt for the more honest response. 
  - *Helpfulness*: In scenarios where both responses are free from hallucinations, you should opt for the more helpful one. The AI should attempt to accomplish the task or answer the question posed, provided it’s not harmful, in the most helpful and engaging manner possible. 

  *Annotation Task*
  Please select the better response from A and B\ 
  [IMAGE]\
  [CONVERSATION CONTEXT]\
  [RESPONSE A]\
  [RESPONSE B]\
  *Question 1*: Which response has fewer hallucinations in terms of the given image?\
  *Question 2*: If you have selected a tie between Response 1 and Response 2 from the previous question, which response would be more helpful or less incorrect? 
],
kind: table,
caption: [给偏好数据标注员的说明]
)<tab:preference_collection>]

#let full_example_qualitative=[#figure(
block(width: 100%,breakable: false,fill: luma(238),stroke: 1pt,radius: 5pt,inset:(top:1em,left:2em,right:2em,bottom:1em))[
  #set par(leading: 0.5em,first-line-indent: 0em)
  #set text(size:10pt)
  #set align(left)
  #grid(columns: (auto,35%),column-gutter: 5%,[
    *Questions*\
    Where is this photo taken? \
    
  #text(fill: rgb("#007f00"))[*Ground Truth:*]\
  From the slogan “Welcome to Houston, Texas”, we can infer that this photo is taken at an airport in Houston, Texas. 

  #text(fill: rgb("0000e5"))[*LLaVA:*]\
  This photo is taken at an airport. 

  #text(fill: rgb("0000e5"))[*LLaVA-SFT#text(baseline: -0.25em)[+]:*]\
  This photo is taken at the Houston airport. 

  #text(fill: rgb("0000e5"))[*LLaVA-RLHF:*]
  ],image("figures/houston_example.jpg"))
  #v(-0.7em)
  This photo is taken in the baggage claim area of an airport, specifically in the lobby of the George Bush Intercontinental Airport in Houston, Texas. The large sign in the background indicates the airport’s name and location. The presence of multiple people, handbags, and suitcases in the scene further supports the fact that this is indeed an airport setting. 
  #line(length: 100%,stroke: 0.5pt)
  #grid(columns: (auto,35%),column-gutter: 5%,[
    *Questions*\
    What is the gender of the person riding the motorcycle in the image?  \
    
  #text(fill: rgb("#007f00"))[*Ground Truth:*]\
  No one is riding the motorcycle in the image. 

  #text(fill: rgb("0000e5"))[*LLaVA:*]\
  The person riding the motorcycle in the image is a woman. 

  #text(fill: rgb("0000e5"))[*LLaVA-SFT#text(baseline: -0.25em)[+]:*]\
  The person riding the motorcycle in the image is a man. 

  #text(fill: rgb("0000e5"))[*LLaVA-RLHF:*]
  ],image("figures/moto_example.jpeg"))
  #v(-0.7em)
  The image does not provide enough information to determine the gender of the person riding the motorcycle. It only shows a motorcycle parked on the side of the road, and there is no indication of the rider’s gender. The rider could be a man or a woman, or even someone who identifies as nonbinary or gender non-conforming. It is important to avoid making assumptions about a person’s gender based on visual cues alone, as these assumptions can be inaccurate and potentially harmful. 
],
kind: table,
caption: [展示RLHF对多模态模型作用的高质量示例。LLaVA-RLHF更有帮助性（上例），并且幻觉更少（下例）。],
)<tab:full_example_qualitative>]

#let _llava_eval={
  tablex(
    auto-lines:false,
    columns:5,
    stroke:1pt,
    align:center+horizon,
    hlinex(),
    rowspanx(2)[Model],colspanx(3)[Subsets],(),(),rowspanx(2)[Full-set],
    hlinex(stroke:0.5pt),
    (),[Conv],[Detail],[Complex],(),
    midhline,
    [LLaVA7B],[75.1],[75.4],[92.3],[81.0],
    [VIGC7B],[83.3],[80.6],[93.1],[85.8],
    [LLaVA-SFT+7B],[88.8],[74.6],[95.0],[86.3],
    [LLaVA-RLHF-7B],[93.0],[79.0],[109.5],[94.1],
    midhline,
    [LLaVA13BX336],[87.2],[74.3],[92.9],[84.9],
    [VIGC13BX336],[88.9],[77.4],[93.5],[86.8],
    [LLaVA-SFT+13B×336],[85.8],[75.5],[93.9],[85.2],[LLaVA-RLHF13B×336],[93.9],[82.5],[110.1],[95.6],
    hlinex()
  )
}
#let llava_eval=[#figure(
  _llava_eval,
  caption:[LLaVA-RLHF在LLaVA-Bench上的自动评测结果。GPT-4比较VLM的输出和纯文本的GPT4的输出，然后给出评分。我们报告VLM与纯文本GPT-4相比的结果。],
  kind:table,
)<tab:llava_eval>]

#let _ablation=tablex(
    auto-lines:false,
    columns:10,
    stroke:1pt,
    column-gutter:-2pt,
    align:center+horizon,
    hlinex(),
    rowspanx(2)[Method],rowspanx(2)[PM],rowspanx(2)[RM],colspanx(3)[*SFT Data*],(),(),rowspanx(2)[*MMBench*],rowspanx(2)[*POPE*],rowspanx(2)[*LLaVA-B*],rowspanx(2)[#box([*MMH#text(size:0.8em)[AL]-B*])],
    (),(),(),midhline,[VQA],[AOK],[Flickr],(),(),(),(),
    midhline,
    [SFT],[7b],[-],[\u{2718}],[\u{2718}],[\u{2718}],[38.7],[76.0],[81.0],[1.3],
    [SFT],[7b],[-],[#sym.checkmark],[\u{2718}],[\u{2718}],[42.9],[82.0],[30.4],[2.0],
    [SFT],[7b],[-],[\u{2718}],[✓],[\u{2718}],[48.5],[79.8],[34.7],[1.1],
    [SFT],[7b],[-],[\u{2718}],[\u{2718}],[✓],[37.8],[77.6],[46.6],[1.5],
    [SFT],[7b],[-],[✓],[✓],[✓],[52.1],[82.7],[86.3],[1.8],
    midhline,
    [RLHF],[7b],[7b],[\u{2718}],[\u{2718}],[\u{2718}],[40.0],[78.2],[85.4],[1.4],
    [RLHF],[7b],[7b],[✓],[✓],[✓],[50.8],[82.7],[87.8],[1.8],[RLHF],[7b],[13b],[✓],[✓],[✓],[48.9],[82.7],[93.4],[1.8],[Fact-RLHF],[7b],[13b],[✓],[✓],[✓],[51.4],[81.5],[94.1],[2.1],
    hlinex()

)

#let ablation=[#figure(
  _ablation,
  caption:[在不同模型（SFT，RLHF和Fact-RLHF），数据混合（添加额外数据的LLaVA），策略模型大小，和奖励模型上的消融实验。],
  kind:table,
)<tab:ablation>]

#ablation