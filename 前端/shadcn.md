[vite 配置](https://ui.shadcn.com/docs/installation/vite)

| react命令                         | vue 命令                              | 作用                         |
| ------------------------------- | ----------------------------------- | -------------------------- |
| pnpm dlx shadcn@latest init<br> | pnpm dlx shadcn-vue@latest init<br> | 初始化，项目依赖 tailwind, 先跟着官网配置 |
| pnpm dlx shadcn@latest add<br>  | pnpm dlx shadcn-vue@latest add<br>  | 添加组件                       |
[components](https://ui.shadcn.com/docs/components)

问题 1: 草稿没有方的概念
问题 2: 双击的医嘱没有 prescId | sourcePrescId
```
//医嘱项目明细
    async queryInspectionRequestTypeDetail (checkBigTypeCode) {
      console.log('项目明细', this.searchFormXm.positionCodes)
      this.loading = true
      
      const code=checkBigTypeCode ? checkBigTypeCode : this.catalogCode;
      let params = {
        pageSize: 99999,
        pageNo: 1,
        isGetExecDept: '1',
        isGetMedBodySample: '1',
        isGetPriceItem: '1',
        isGetCustomAttribute: '1',
        isGetHospPrice: '1',
        isDelete: 'N',
        keyword: this.searchFormXm.keyword,
        orderType: 5,
        // itemTypeId: '',
        checkBigTypeCode: code=='-3'?this.searchFormXm.catalogCode||'':code,
        medicalType: '0',
        positionCodes: this.searchFormXm.positionCodes,
        execDeptId: this.searchFormXm.execDeptId,
        // categoryCode: this.filterObj.busiCatgCode||''
      }
      const res = await this.$api({
                                    method: 'post',
                                    url: '/ts-bs-his/ts-bs-bas/queryInspectionRequestTypeDetail',
                                    // url: 'https://mock.apifox.com/m1/3222015-0-default/ts-bs-bas/queryInspectionRequestTypeDetail',
                                    data: params,
                                    headers: {
                                      'Content-Type': 'application/json; charset=utf-8',
                                    },
                                  })
      // this.listData2 = this.groupArr(res.list,'itemTypeId')
      this.loading = false
      if (!res.data.list) {
        this.listData2 = []
        this.zxksList = []
        return
      }
      let keys = Object.keys(res.data.list)
      let list = []
      keys.map((item) => {
        //排除科室
        if (item != 'orderDeptList') {
          const obj={
                      title: item,
                      isExpand: true,
                      list: this.getDefaultData(res.data.list[item]),
                    }
          if(obj.list?.length){
            list.push(obj)
          }
        }
        // return {
        //   title: item,
        //   isExpand: true,
        //   list: res.data[item]
        // }
      })
      this.zxksList = res.data?.list?.orderDeptList || []
      this.listData2 = this.getDefaultData(list || [])
      console.log(this.listData2)
    }
```