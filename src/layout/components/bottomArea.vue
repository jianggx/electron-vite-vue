<template>
    <el-tabs type='border-card' tab-position="bottom" class="w-full h-full">
        <el-tab-pane class="h-full" label='日志详情'>
            <log-detail-panel></log-detail-panel>
        </el-tab-pane>
        <el-tab-pane class="h-full" label='查询结果'>
        </el-tab-pane>
        <el-tab-pane class="h-full" label='输出'>
        </el-tab-pane>
    </el-tabs>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import LogDetailPanel from '/@/layout/components/logDetailPanel.vue'

</script>
