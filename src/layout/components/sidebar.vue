<template>
  <div class="h-full w-full flex flex-col "> 
    <div class='layout-sidebar-logo text-sm flex h-7 relative flex-center'>
        <el-text>测试项目xxx</el-text>
    </div>
    <div class='border-1 border-solid border-gray-300 flex-1 h-full overflow-auto'>
      <el-tree
        default-expand-all
        :data="data"
        :props="defaultProps"
      >
        <template #default="{ node, data }">
          <span class="custom-node w-full" @dblclick="handleDbClick(node, data)">
            <!-- 根据节点类型切换图标 -->
            <el-icon v-if="data.type === 'log'"> 
              <Document />
            </el-icon>
            <el-icon v-else-if="data.type === 'device'">
              <Cpu />
            </el-icon>
            <el-icon v-else-if="data.type === 'analysis'">
              <Histogram />
            </el-icon>
            <span>{{ node.label  }}</span>
          </span>
        </template>      
      </el-tree>
    </div>
  </div>


</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { Document, Cpu, Histogram } from '@element-plus/icons-vue'


interface Tree {
  label: string,
  type: string
  children?: Tree[]
}

const handleDbClick = (node, data) => {
  alert(data.type + ': ' + data.label)
  return true
}

const data: Tree[] = [
  {
    label: 'SDR-1',
    type: 'device', 
    children: [
      { label: 'analysis-1', type: 'analysis'},
      { label: 'analysis-2', type: 'analysis'},      
      { label: 'log-2021-09-01', type: 'log'},
      { label: 'log-2021-09-02', type: 'log'},
      { label: 'log-2021-09-03', type: 'log'},
    ],
  },
  {
    label: 'KA-1',
    type: 'device',
    children: [
      { label: 'analysis-1', type: 'analysis'},
      { label: 'analysis-2', type: 'analysis'},      
      { label: 'log-2021-09-01', type: 'log'},
      { label: 'log-2021-09-02', type: 'log'},
      { label: 'log-2021-09-03', type: 'log'},
    ],
  },
  {
    label: 'KA-2',
    type: 'device',
    children: [
      { label: 'analysis-1', type: 'analysis'},
      { label: 'analysis-2', type: 'analysis'},      
      { label: 'log-2021-09-01', type: 'log'},
      { label: 'log-2021-09-02', type: 'log'},
      { label: 'log-2021-09-03', type: 'log'},
    ],
  },
  { label: 'analysis-1', type: 'analysis'},
  { label: 'analysis-2', type: 'analysis'},    
]

const defaultProps = {
  children: 'children',
  label: 'label',
}
</script>
