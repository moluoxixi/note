### 常见 AI 工具对比表

| 工具名称             | 简介                                      | 适用场景                        | GitHub 地址                                                 | 官网地址                              |
| ---------------- | --------------------------------------- | --------------------------- | --------------------------------------------------------- | --------------------------------- |
| **LangChain**    | 开源框架，支持通过模块化组件构建复杂 LLM 应用（如问答、工作流）      | 开发者定制化开发（私有数据集成、复杂逻辑）       | [GitHub](https://github.com/langchain-ai/langchain)       | [官网](https://www.langchain.com)   |
| **Dify**         | 低代码平台，可视化构建和部署 AI 应用（聊天机器人、内容生成等）       | 企业快速部署标准化应用（客服助手、无代码 AI 工具） | [GitHub](https://github.com/langgenius/dify)              | [官网](https://dify.ai)             |
| **AutoGPT**      | 自主动作代理，可分解任务并自动执行（搜索、生成、迭代）             | 自动化多步骤任务（调研、报告生成）           | [GitHub](https://github.com/Significant-Gravitas/AutoGPT) | [官网](https://agpt.co)             |
| **LlamaIndex**   | 数据连接框架，优化 LLM 与结构化/非结构化数据的交互            | 构建高效检索系统（知识库问答、文档分析）        | [GitHub](https://github.com/jerryjliu/llama_index)        | [官网](https://www.llamaindex.ai)   |
| **Hugging Face** | 开源社区与平台，提供模型库、数据集和部署工具（Transformers 库等） | 模型训练/微调、快速实验（NLP/CV 任务）     | [GitHub](https://github.com/huggingface/transformers)     | [官网](https://huggingface.co)      |
| **Haystack**     | 开源框架，专注于构建端到端问答、搜索和对话系统                 | 企业级搜索系统（文档检索、智能问答）          | [GitHub](https://github.com/deepset-ai/haystack)          | [官网](https://haystack.deepset.ai) |
# 前端开发者 AI 学习路线（附模板与 Demo）

---

## 学习路线表

| 阶段       | 学习目标                 | 推荐模板/Demo                                                                                                                                                                          | 核心工具与资源                                                                                                            |
| -------- | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| **基础入门** | 掌握 API 调用与 Prompt 设计 | - [Vercel AI 聊天模板](https://github.com/vercel-labs/ai/tree/main/examples/next-chat)<br>- [TensorFlow.js 图片分类 Demo](https://github.com/tensorflow/tfjs-models/tree/master/mobilenet) | - [OpenAI API 文档](https://platform.openai.com/docs)<br>- [Vercel AI SDK](https://vercel.ai)                        |
| **进阶实战** | 实现多模态交互与私有化部署        | - [语音控制待办事项 Demo](https://github.com/openai/whisper/discussions/2)<br>- [Supabase 知识库模板](https://github.com/supabase-community/nextjs-openai-doc-search)                           | - [HuggingFace API](https://huggingface.co/docs/api-inference)<br>- [Supabase Vector](https://supabase.com/vector) |
| **拓展优化** | 集成 RAG 与性能优化         | - [Langchain.js 文档问答 Demo](https://github.com/hwchase17/langchainjs)<br>- [TF.js 模型量化示例](https://github.com/tensorflow/tfjs/tree/master/tfjs-converter)                            | - [Langchain.js](https://js.langchain.com/docs)<br>- [Web AI 优化指南](https://web.dev/optimize-ai-models/)            |

---

## 分阶段学习计划与模板

### 阶段一：基础入门（2 周）
- [ ] **Week 1：OpenAI API 与聊天机器人**  
  - **目标**：调用 ChatGPT 实现对话功能  
  - **模板**：[Next.js + Vercel AI 聊天模板](https://github.com/vercel-labs/ai/tree/main/examples/next-chat)  
  - **任务**：  
    1. 克隆模板仓库，部署到 Vercel  
    2. 修改提示词，实现角色扮演（如“客服助手”）  
    3. 输出：可定制的聊天组件（支持流式响应）  

- [ ] **Week 2：浏览器端 AI 模型**  
  - **目标**：在浏览器运行轻量模型  
  - **Demo**：[TensorFlow.js 图片分类示例](https://github.com/tensorflow/tfjs-models/tree/master/mobilenet#demo)  
  - **任务**：  
    1. 使用 MobileNet 实现图片分类  
    2. 添加拖拽上传功能（参考 [CodeSandbox 示例](https://codesandbox.io/s/tensorflow-js-image-classification-3p2fz))  
    3. 输出：支持实时分类的 Web 应用  

---

### 阶段二：进阶实战（3 周）
- [ ] **Week 3：HuggingFace 集成与智能表单**  
  - **目标**：调用 NLP 模型增强表单功能  
  - **模板**：[React 智能表单 Demo](https://github.com/huggingface/react-transformers)  
  - **任务**：  
    1. 集成 HuggingFace 文本摘要 API  
    2. 实现输入框自动补全（如地址、关键词）  
    3. 输出：支持 AI 校验的表单系统  

- [ ] **Week 4：语音交互应用**  
  - **目标**：结合 Whisper API 实现语音控制  
  - **Demo**：[Whisper + React 录音组件](https://github.com/ggerganov/whisper.cpp/tree/master/examples/whisper-react)  
  - **任务**：  
    1. 实现浏览器录音并调用 Whisper API 转文本  
    2. 开发语音控制的待办事项列表  
    3. 输出：语音驱动的任务管理应用  

- [ ] **Week 5：私有化知识库**  
  - **目标**：搭建本地问答系统  
  - **模板**：[Supabase + OpenAI 文档搜索模板](https://github.com/supabase-community/nextjs-openai-doc-search)  
  - **任务**：  
    1. 使用 Supabase Vector 存储 PDF 文本向量  
    2. 实现基于 RAG 的问答接口  
    3. 输出：私有化文档助手  

---

### 阶段三：拓展优化（2 周）
- [ ] **Week 6：性能优化与 RAG 增强**  
  - **目标**：提升 AI 应用速度与准确性  
  - **Demo**：[Langchain.js + Supabase 问答系统](https://github.com/supabase-community/vercel-ai-chat-template)  
  - **任务**：  
    1. 量化 TensorFlow.js 模型，减少加载时间  
    2. 添加缓存策略（如 IndexedDB 存储模型）  
    3. 输出：低延迟文档问答应用  

- [ ] **Week 7：多模态综合项目**  
  - **目标**：开发全功能 AI 仪表盘  
  - **模板**：[AI 仪表盘 Starter](https://github.com/nocodb/nocoai-starter)  
  - **任务**：  
    1. 集成聊天、语音、图像生成（DALL·E）  
    2. 部署到 Vercel/Supabase  
    3. 输出：可上线多模态应用  

---

## 关键资源直达
- **模板仓库**：  
  - [Vercel AI 官方示例](https://github.com/vercel-labs/ai/tree/main/examples)  
  - [Supabase AI 模板合集](https://github.com/supabase-community/ai-showcase)  
- **工具文档**：  
  - [Transformers.js](https://xenova.github.io/transformers.js/)  
  - [Langchain.js 中文指南](https://js.langchain.com/docs/get_started/introduction)