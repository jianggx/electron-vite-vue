<template>
    <div class='layout-navbar-search hidden-xs-only cursor-pointer flex flex-center px-2' :class='{"open": isShow}'>
        <svg-icon class-name='svg-icon' icon-class='svg-search' @click.stop='changeStatus' />
        <div class='layout-navbar-search-select'>
            <el-select
                ref='elSelect'
                v-model='href'
                filterable
                placeholder='search'
                remote
                :remote-method='searchText'
                @change='changeRoute'
            >
                <el-option v-for='item in searchList' :key='item.path' :label='item.searchLabel' :value='item.path' />
            </el-select>
        </div>
    </div>
</template>
<script lang='ts'>
import { defineComponent, Ref, ref, watch } from 'vue'
import { useLayoutStore } from '/@/store/modules/layout'
import { IMenubarList, ISetting } from '/@/type/store/layout'
import { useRouter } from 'vue-router'
import Fuse from 'fuse.js'

// 不使用则不加载
const pinyin = () => import('pinyin')

interface ISearchList extends IMenubarList{
    searchLabel: string
    pinyinTitle?: string
}
// 搜索查询
const search = async(searchList:Ref<ISearchList[]>, menuList: IMenubarList[], setting: ISetting) => {
    const fuseList:ISearchList[] = []
    const f = async(list:IMenubarList[], text: string) => {
        for(let v of list) {
            const obj:ISearchList = Object.assign({}, v, { 
                searchLabel: text + v.meta.title
            })

            fuseList.push(obj)
            if(v.children && v.children.length > 0) {
                f(v.children, `${text + v.meta.title} > `)
            }
        }
    }
    await f(menuList, '')

    const FuseOpts = () => {
        return {
            shouldSort: true,
            threshold: 0.4,
            location: 0,
            distance: 100,
            minMatchCharLength: 1,
            includeScore: true,
            keys: ['meta.title', 'path']
        }
    }
    let fuse = new Fuse(fuseList, FuseOpts())
    
    const searchText = (query: string) => {
        if(query !== '') {
            searchList.value = fuse.search(query).map(v => v.item)
        }else{
            searchList.value = []
        }
    }

    return searchText
}
// search显示隐藏状态
const changeSearchStatus = (searchList:Ref<ISearchList[]>) => {
    const router = useRouter()
    const href = ref('')
    const isShow = ref(false)
    const elSelect = ref()
    const changeStatus = () => {
        isShow.value = !isShow.value
        if(isShow.value && elSelect.value) {
            elSelect.value.focus()
        }
    }

    const hideSearch = () => {
        href.value = ''
        searchList.value.splice(0, searchList.value.length)
        isShow.value = false
    }

    watch(isShow, (newValue) => {
        if(newValue) {
            document.body.addEventListener('click', hideSearch)
        }else{
            document.body.removeEventListener('click', hideSearch)
        }
    })

    const changeRoute = () => {
        router.push({ path: href.value })
        hideSearch()
    }

    return {
        href,
        changeRoute,
        changeStatus,
        isShow,
        elSelect,
        hideSearch
    }
}

export default defineComponent({
    name: 'Search',
    setup() {
        const { getMenubar, getSetting } = useLayoutStore()
        const searchList:Ref<ISearchList[]> = ref([])
        const searchText:Ref<null | ((query: string) => void)> = ref(null)

        search(searchList, getMenubar.menuList, getSetting).then(data => {
            searchText.value = data
        })

        return {
            searchList,
            searchText,
            ...changeSearchStatus(searchList)
        }
    }
})
</script>

<style lang='postcss' scoped>
    ::v-deep(.el-input__inner) {
        border-top: none;
        border-left: none;
        border-right: none;
        border-radius: 0;
    }

    ::v-deep(.el-select__caret) {
        display: none;
    }

    .layout-navbar-search {
        .layout-navbar-search-select {
            transition: width 0.2s;
            width: 0;
            overflow: hidden;
        }

        &.open {
            .layout-navbar-search-select {
                width: 210px;
            }
        }
    }
</style>