<template>
    <div class='layout flex flex-col h-screen w-screen'>
    <div class="flex flex-row h-full" >
        <div
            class='layout-sidebar flex flex-col transition-width duration-200 shadow'
            :class='{ 
                "absolute z-30": getMenubar.status === 2 || getMenubar.status === 3, 
            }'
        >
            <div class='layout-sidebar-logo flex h-10 relative flex-center shadow-lg'>
                项目浏览器
            </div>
            <div class='layout-sidebar-menubar flex flex-1 overflow-hidden'>
                <el-scrollbar wrap-class='scrollbar-wrapper'>
                    <layout-sidebar />
                </el-scrollbar>
            </div>
        </div>
        <div class='layout-main flex flex-1 flex-col overflow-x-hidden overflow-y-auto'>
            <div class='layout-main-content h-full overflow-hidden'>
                <layout-content />
            </div>
            <div class="flex h-50">
                <layout-bottombar />
            </div>
        </div>
    </div>
    <div class="flex h-6">
        <LayoutStatusbar />
    </div>
    </div>
</template>

<script lang='ts' setup>
import { onMounted } from 'vue'
import LayoutContent from '/@/layout/components/content.vue'
import LayoutSidebar from '/@/layout/components/sidebar.vue'
import LayoutStatusbar from '/@/layout/components/statusbar.vue'
import LayoutBottombar from '/@/layout/components/bottombar.vue'
import { useLayoutStore } from '/@/store/modules/layout'


const { changeDeviceWidth, changeCollapsed, getMenubar, getSetting } = useLayoutStore()


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