<template>
    <el-tabs type='border-card' tab-position="bottom" class="w-full">
        <el-tab-pane label='日志详情'>
        </el-tab-pane>
        <el-tab-pane label='查询结果'>
        </el-tab-pane>
        <el-tab-pane label='输出'>
        </el-tab-pane>
    </el-tabs>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import List, { IList } from '/@/components/List/index.vue'

export default defineComponent({
    name: 'BottomBar',
    components: {
        List
    },
    setup() {
        const data:IList[] = [
            { 
                iconClass: 'el-icon-goods',
                subTitle: '斗通关无际县军连用知政以该果思快领c。',
                tag: '科学搬砖组',
                time: '2021/01/28 15:21:32',
                href: 'javascript:;'
            },
            { 
                iconClass: 'el-icon-goods',
                subTitle: '斗通关无际县军连用知政以该果思快领c。',
                tag: '科学搬砖组',
                time: '2021/01/28 15:21:32',
                href: 'javascript:;'
            },
            { 
                iconClass: 'el-icon-goods',
                subTitle: '斗通关无际县军连用知政以该果思快领c。',
                tag: '科学搬砖组',
                time: '2021/01/28 15:21:32',
                href: 'javascript:;'
            }
        ]

        const edit = (item:IList) => console.log(item)
        return {
            data,
            edit
        }
    }
})
</script>
