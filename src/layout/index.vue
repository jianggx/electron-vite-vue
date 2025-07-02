<template>
<div class='layout flex flex-col h-screen w-screen'>
    <div class="flex flex-row h-full" >
        <el-splitter>
        <el-splitter-panel :size="220">
            <div class='flex h-full w-full overflow-hidden'>   
                <layout-sidebar />
            </div>
        </el-splitter-panel>
        <el-splitter-panel :min="200">
            <div class='flex h-full flex-1 flex-col'>
                <el-splitter layout="vertical">
                <el-splitter-panel :min="200">
                    <div class='h-full overflow-hidden'>
                        <layout-content />
                    </div>
                </el-splitter-panel>
                <el-splitter-panel :size="220">
                    <div class="flex h-full">
                        <bottom-area />
                    </div>
                </el-splitter-panel>
                </el-splitter>
            </div>
        </el-splitter-panel>
        </el-splitter>



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
import BottomArea from '/@/layout/components/bottomArea.vue'
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

    .el-tab-pane {
        height: 100%;
    }   
</style>