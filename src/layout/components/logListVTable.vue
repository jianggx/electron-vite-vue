<template>
  <div class="w-full h-full">
    <el-auto-resizer>
      <template #default="{ height, width }">
        <el-table-v2
          ref="tableRef"
          :columns="columns"
          :data="data"
          :width="width"
          :height="height"
          fixed
          :row-event-handlers="rowHandlers"
          :header-height="25"
          :row-height="22"
          :row-class="rowClass"
        />
      </template>
    </el-auto-resizer>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import type { Column, RowClassNameGetter } from 'element-plus'
import { TableV2FixedDir, TableV2Instance } from 'element-plus'

const tableRef = ref<TableV2Instance>()

const logExamples = [ { msgType:"trace", frameType:"entire", CpuId:"0", modId:"PHY", traceLevel:"Debug", timeStamp_t:"2025-06-21 14:30:05", traceFlag:"unilog", srcTaskId:"", srcProcId:"", destTaskId:"", destProcId:"", sapId:"", primId:"", messageName:"", timeStamp_d:""},
                      { msgType:"diag",  frameType:"entire", CpuId:"0", modId:"", traceLevel:"", timeStamp_t:"", traceFlag:"", srcTaskId:"11(tABC)", srcProcId:"113(POCC_EE)", destTaskId:"11(tABC)", destProcId:"113(POCC_EE)", sapId:"2(AED_AEE)", primId:"22323(STEE_SFSDFS_EEEE_PROCC)", messageName:"DED_EE_YUIG", timeStamp_d:"2025-06-21 14:30:05"}
                    ]

const columns: Column<any>[] = [
  {
    key: 'lineNo',
    title: '',
    dataKey: 'lineNo',
    width: 80,
    fixed: TableV2FixedDir.LEFT,
  },
  {
    key: 'msgType',
    title: '消息类型',
    dataKey: 'msgType',
    width: 80,
  },
  {
    key: 'frameType',
    title: '帧类型',
    dataKey: 'frameType',
    width: 80,
    align: 'center',
  },
  {
    key: 'CpuId',
    title: 'CPU',
    dataKey: 'CpuId',
    width: 80,
    align: 'center',
  },
  {
    key: 'modId',
    title: '模块Id',
    dataKey: 'modId',
    width: 80,
    align: 'center',
  },
  {
    key: 'traceLevel',
    title: 'traceLevel',
    dataKey: 'traceLevel',
    width: 80,
    align: 'center',
  },
  {
    key: 'timeStamp_t',
    title: 'timeStamp',
    dataKey: 'timeStamp_t',
    width: 150,
    align: 'center',
  },
  {
    key: 'traceFlag',
    title: 'traceFlag',
    dataKey: 'traceFlag',
    width: 80,
    align: 'center',
  },
  {
    key: 'srcTaskId',
    title: 'srcTaskId',
    dataKey: 'srcTaskId',
    width: 80,
    align: 'center',
  },
  {
    key: 'srcProcId',
    title: 'srcProcId',
    dataKey: 'srcProcId',
    width: 80,
    align: 'center',
  },
  {
    key: 'destTaskId',
    title: 'destTaskId',
    dataKey: 'destTaskId',
    width: 80,
    align: 'center',
  },
  {
    key: 'destProcId',
    title: 'destProcId',
    dataKey: 'destProcId',
    width: 80,
    align: 'center',
  },
  {
    key: 'sapId',
    title: 'sapId',
    dataKey: 'sapId',
    width: 80,
    align: 'center',
  },
  {
    key: 'primId',
    title: 'primId',
    dataKey: 'primId',
    width: 80,
    align: 'center',
  },
  {
    key: 'messageName',
    title: 'messageName',
    dataKey: 'messageName',
    width: 80,
    align: 'center',
  },
  {
    key: 'timeStamp_d',
    title: 'timeStamp_d',
    dataKey: 'timeStamp_d',
    width: 150,
    align: 'center',
  }
]

let lineNo = 1
const dataGenerator = () =>{ 
    let item:any = {... Math.random() > 0.5 ? logExamples[0] : logExamples[1]}
    item['lineNo'] = lineNo
    item["id"] = `${lineNo}`;
    lineNo++
    return item
}
const data =  Array.from({ length: 10000 }).map(dataGenerator)

const rowHandlers = {
  // 单击事件 
  onClick: ({ event, rowData, rowIndex, rowKey }: { 
    event: Event, 
    rowData: Object, 
    rowIndex: number, 
    rowKey?: string | number 
  }) => {
    console.log(" 单击行数据:", event);
    console.log(" 行索引:", rowData);
  },

  ondblclick: ({ event, rowData, rowIndex, rowKey }: { 
    event: Event, 
    rowData: Object, 
    rowIndex: number, 
    rowKey?: string | number 
  }) => {
    scrollToBottom()
    //alert(`行索引: ${rowData.lineNo}`);
  },
};


function scrollToBottom() {
  tableRef.value?.scrollToRow(100000000)
}

const rowClass = ({ rowIndex }: Parameters<RowClassNameGetter<any>>[0]) => {
  if(rowIndex >= data.length)
    return ""

  const item = data[rowIndex]
  if(item.msgType === "trace") {
    return 'bg-gray-100'
  } else if (item.msgType === "diag") {
    return 'bg-gray-500'
  }
  return ''
}

</script>

<style scoped>
:deep(.el-table-v2__header-cell){
    background-color:ghostwhite;
}
</style>