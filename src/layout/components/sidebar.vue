<template>
  <div class="h-full w-full flex flex-col "> 
    <div class='layout-sidebar-logo text-sm flex h-7 relative flex-center'>
        测试项目xxx
    </div>
    <div class='border-1 border-solid border-gray-300 flex-1 h-full overflow-auto'>
      <el-tree
        default-expand-all
        :data="data"
        :props="defaultProps"
        @node-click="handleNodeClick"
      />
    </div>
  </div>


</template>

<script lang="ts" setup>
interface Tree {
  label: string
  children?: Tree[]
}

const handleNodeClick = (data: Tree) => {
  console.log(data)
}

const data: Tree[] = [
  {
    label: 'SDR-1',
    children: [
      { label: 'analysis-1'},
      { label: 'analysis-2'},      
      { label: 'log-2021-09-01'},
      { label: 'log-2021-09-02'},
      { label: 'log-2021-09-03'},
    ],
  },
  {
    label: 'KA-1',
    children: [
      { label: 'analysis-1'},
      { label: 'analysis-2'},      
      { label: 'log-2021-09-01'},
      { label: 'log-2021-09-02'},
      { label: 'log-2021-09-03'},
    ],
  },
  {
    label: 'KA-2',
    children: [
      { label: 'analysis-1'},
      { label: 'analysis-2'},      
      { label: 'log-2021-09-01'},
      { label: 'log-2021-09-02'},
      { label: 'log-2021-09-03'},
    ],
  },
  { label: 'analysis-1'},
  { label: 'analysis-2'},    
]

const defaultProps = {
  children: 'children',
  label: 'label',
}
</script>
