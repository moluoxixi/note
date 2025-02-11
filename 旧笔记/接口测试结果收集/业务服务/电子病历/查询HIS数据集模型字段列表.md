
# 业务服务/电子病历 - 查询HIS数据集模型字段列表 - 类型校验-[pageSize]类型错误
## 请求参数:
``` json
{
  "pageIndex": 1,
  "orgCode": "NXRMYY",
  "pageSize": "abc"
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
# 业务服务/电子病历 - 查询HIS数据集模型字段列表 - 类型校验-[pageIndex]类型错误
## 请求参数:
``` json
{
  "pageIndex": "abc",
  "orgCode": "NXRMYY",
  "pageSize": 3
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