### Axios

```
export class Axios {
  request<T = any, R = AxiosResponse<T,D>, D = any>(config: AxiosRequestConfig<D>): Promise<R>;
    
  get<T = any, R = AxiosResponse<T>, D = any>(url: string, config?: AxiosRequestConfig<D>): Promise<R>;
    
  post<T = any, R = AxiosResponse<T>, D = any>(url: string, data?: D, config?: AxiosRequestConfig<D>): Promise<R>;
  ......
}
```

### AxiosResponse

```
export interface AxiosResponse<T = any, D = any>  {
  data: T;
  status: number;
  config: AxiosRequestConfig<D>;
}
```

### AxiosRequestConfig

```
export interface AxiosRequestConfig<D = any> {
  data?: D;
  params?:any;
  url?: string;
  // .....
}
​
```