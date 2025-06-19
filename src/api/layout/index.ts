import request from '/@/utils/request'
import { AxiosResponse } from 'axios'
import { IMenubarList } from '/@/type/store/layout'
import { login, getUser1, getRoute } from '/@/api/layout/response'

const api = {
    login: '/api/User/login',
    getUser: '/api/User/getUser',
    getRouterList: '/api/User/getRoute',
    publickey: '/api/User/Publickey'
}

export function publickey():Promise<AxiosResponse<IResponse<string>>> {
    return request({
        url: api.publickey,
        method: 'get'
    })
}

interface IGetuserRes {
    name: string
    role: Array<string>
}

export function getUser(): Promise<IGetuserRes> {
    return Promise.resolve(getUser1('admin')) 
}

export function getRouterList(): Promise<Array<IMenubarList>> {
    return Promise.resolve(getRoute('admin'))
}