<template>
<div class="flex h-full flex-row">
    <el-splitter>
      <el-splitter-panel>
        <div class="w-full h-full overflow-auto">
            <el-tree class="w-full h-full"
                default-expand-all
                :data="data"
                :props="defaultProps"
                @node-click="handleNodeClick"
            />
        </div>
      </el-splitter-panel>
      <el-splitter-panel :size="450" >
        <div class="text-sm h-full w-120 overflow-auto p-1">
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
            <div>10 00 3f 26 ac 33 22 10 &nbsp; 00 01 10 ff 10 10 00 ac &nbsp; &nbsp; ..Ma...1 &nbsp; ..a.,]..</div>
        </div>  
      </el-splitter-panel>
    </el-splitter>
</div>
</template>

<script lang="ts" setup>
import { ref } from 'vue'

interface Tree {
  label: string
  children?: Tree[]
}

const handleNodeClick = (data: Tree) => {
  console.log(data)
}
const data: Tree[] = [
{
'label': 'Frame 121: 86 bytes on wire (688 bits), 86 bytes captured (688 bits) on interface en0, id 0',
'children': [
    {'label': 'Section number: 1'},
    {'label':'Interface id: 0 (en0)',
        'children': [
            {'label': 'Interface name: en0'},
            {'label': 'Interface description: Wi-Fi'},
            {'label': 'Interface MAC address: 00:1c:42:05:05:05 (00:1c:42:05:05:05)'},
            {'label': 'Interface IPv4 address: 192.168.1.5'},
        ]
    },
    {'label': 'Encapsulation type: Ethernet (1)'},
    {'label': 'Arrival Time: Jun 30, 2025 21:48:25.260881000 CST'},
    {'label': 'UTC Arrival Time: Jun 30, 2025 13:48:25.260881000 UTC'},
    {'label': 'Epoch Arrival Time: 1751291305.260881000'},
    {'label': '[Time shift for this packet: 0.000000000 seconds]'},
    {'label': '[Time delta from previous captured frame: 0.006977000 seconds]'},
    {'label': '[Time delta from previous displayed frame: 0.006977000 seconds]'},
    {'label': '[Time since reference or first frame: 12.765336000 seconds]'},
    {'label': 'Frame Number: 121'},
    ]
},
{
'label': 'Ethernet II, Src: c2:84:ea:f2:4d:75 (c2:84:ea:f2:4d:75), Dst: Apple_d9:8b:a7 (6c:96:cf:d9:8b:a7)======================================================================',
'children': [
    {'label':'Destination: Apple_d9:8b:a7 (6c:96:cf:d9:8b:a7)',
     'children':[
        {'label':'.... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)'},
        {'label':'.... ...0 .... .... .... .... = IG bit: Individual address (unicast)'},
    ]},
    {'label':'Source: c2:84:ea:f2:4d:75 (c2:84:ea:f2:4d:75)'},
    {'label':'Type: IPv6 (0x86dd)'},
    {'label':'[Stream index: 0]'},
    ]
}
]

const data2: Tree[] = [
  {
    label: 'Level one 1',
    children: [
      {
        label: 'Level two 1-1',
        children: [
          {
            label: 'Level three 1-1-1',
          },
        ],
      },
    ],
  },
  {
    label: 'Level one 2',
    children: [
      {
        label: 'Level two 2-1',
        children: [
          {
            label: 'Level three 2-1-1',
          },
        ],
      },
      {
        label: 'Level two 2-2',
        children: [
          {
            label: 'Level three 2-2-1',
          },
        ],
      },
    ],
  },
  {
    label: 'Level one 3',
    children: [
      {
        label: 'Level two 3-1',
        children: [
          {
            label: 'Level three 3-1-1',
          },
        ],
      },
      {
        label: 'Level two 3-2',
        children: [
          {
            label: 'Level three 3-2-1',
          },
        ],
      },
    ],
  },
]

const defaultProps = {
  children: 'children',
  label: 'label',
}

</script>
