
# 业务服务/电子病历 - 获取HIS数据源的门诊检查报告结果数据集 - 必填校验-[orgCode]为空
## 请求参数:
``` json
{
  "orgCode": "",
  "pageSize": 10,
  "pageIndex": 1
}
```
## 返回参数:
``` json
{
  "exception": null,
  "apiCode": null,
  "data": null,
  "Code": 1,
  "Message": "医院编码不能为空"
}
```
# 业务服务/电子病历 - 获取HIS数据源的门诊检查报告结果数据集 - 必填校验-[pageIndex]为空
## 请求参数:
``` json
{
  "orgCode": "NXRMYY",
  "pageSize": 10,
  "pageIndex": null
}
```
## 返回参数:
``` json
{
  "exception": null,
  "apiCode": null,
  "data": null,
  "Code": 1,
  "Message": "系统内部异常"
}
```
# 业务服务/电子病历 - 获取HIS数据源的门诊检查报告结果数据集 - 必填校验-[pageSize]为空
## 请求参数:
``` json
{
  "orgCode": "NXRMYY",
  "pageSize": null,
  "pageIndex": 1
}
```
## 返回参数:
``` json
{
  "exception": null,
  "apiCode": null,
  "data": null,
  "Code": 1,
  "Message": "系统内部异常"
}
```
# 业务服务/电子病历 - 获取HIS数据源的门诊检查报告结果数据集 - 类型校验-[pageIndex]类型错误
## 请求参数:
``` json
{
  "orgCode": "NXRMYY",
  "pageSize": 10,
  "pageIndex": "abc"
}
```
## 返回参数:
``` json
{
  "exception": null,
  "apiCode": null,
  "data": null,
  "Code": 1,
  "Message": "请求参数错误"
}
```
# 业务服务/电子病历 - 获取HIS数据源的门诊检查报告结果数据集 - 类型校验-[pageSize]类型错误
## 请求参数:
``` json
{
  "orgCode": "NXRMYY",
  "pageSize": "abc",
  "pageIndex": 1
}
```
## 返回参数:
``` json
{
  "exception": null,
  "apiCode": null,
  "data": null,
  "Code": 1,
  "Message": "请求参数错误"
}
```