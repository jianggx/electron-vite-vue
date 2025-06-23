<template>
    <div class='layout flex h-screen'>
        <div class='layout-sidebar-mask fixed w-screen h-screen bg-black bg-opacity-25 z-20' :class='{"hidden": getMenubar.status !== 2 }' @click='changeCollapsed' />
        <div
            class='layout-sidebar flex flex-col h-screen transition-width duration-200 shadow'
            :class='{ 
                "absolute z-30": getMenubar.status === 2 || getMenubar.status === 3, 
            }'
        >
            <div class='layout-sidebar-logo flex h-12 relative flex-center shadow-lg'>
                项目浏览器
            </div>
            <div class='layout-sidebar-menubar flex flex-1 overflow-hidden'>
                <el-scrollbar wrap-class='scrollbar-wrapper'>
                    <layout-menubar />
                </el-scrollbar>
            </div>
        </div>
        <div class='layout-main flex flex-1 flex-col overflow-x-hidden overflow-y-auto'>
            <div class='layout-main-content flex-1 overflow-hidden'>
                <layout-content />
            </div>
        </div>
    </div>
</template>

<script lang='ts'>
import { defineComponent, onMounted } from 'vue'
import LayoutContent from '/@/layout/components/content.vue'
import LayoutMenubar from '/@/layout/components/menubar.vue'
import { throttle } from '/@/utils/tools'
import { useLayoutStore } from '/@/store/modules/layout'
import icon from '/@/assets/img/icon.png'

export default defineComponent ({
    name: 'Layout',
    components: {
        LayoutContent,
        LayoutMenubar,
    },
    setup() {
        const { changeDeviceWidth, changeCollapsed, getMenubar, getSetting } = useLayoutStore()

        onMounted(async() => {
            changeDeviceWidth()
            const throttleFn = throttle(300)
            let throttleF = async function() {
                await throttleFn()
                changeDeviceWidth()
            }
            window.addEventListener('resize', throttleF, true)
        })

        return {
            getMenubar,
            getSetting,
            changeCollapsed,
            icon
        }
    }
})
</script>

<style lang='postcss' scoped>
    ::v-deep(.el-menu--horizontal>.el-menu-item) {
        height: 48px;
    }

    ::v-deep(.el-menu--horizontal>.el-sub-menu .el-sub-menu__title) {
        height: 48px;
        line-height: 48px;
    }
</style>