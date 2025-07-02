<template>
    <div class="flex h-full  flex-col">
        <div class="flex m-1 flex-row"> 
            <el-button-group>
                <el-button @click="myaleret('连接')">连接</el-button>
                <el-button @click="">断开</el-button>
            </el-button-group>

            <div class="flex flex-row flex-1 justify-end items-center"> 
                <el-text>自定义脚本:</el-text> 
                <div class="flex w-60 ml-1">
                    <el-select class="flex" v-model="custom_script" placeholder="Select">
                        <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value"
                        />
                    </el-select>                      
                </div>
                <el-button-group>
                    <el-button class="flex" @click="">查询</el-button>
                    <el-button class="flex" @click="">执行</el-button>
                </el-button-group>
            </div>
        </div>
        <div class="flex m-1 flex-row "> 
            <div class="flex w-95">
                <el-input
                    v-model="search_input"
                    placeholder="Please input"   
                >
                <template #prepend>
                    <el-button  @click="myaleret('过滤设置')" >过滤设置</el-button>
                </template>
                <template #append>
                    <el-button class="flex" @click="">搜索</el-button>
                </template>
                </el-input>
                <el-checkbox-button class="wildcarc_pattern flex m-0 p-0" style="position: relative; left: -79px;">.*</el-checkbox-button>
            </div>
            <div class="flex flex-row flex-1 justify-end items-center"> 
                <div class="flex w-80">
                    <el-input class="flex" v-model="query_input" placeholder="请输入内容" />
                </div>
                <el-button class="flex" @click="">查询</el-button>
                <el-button class="flex" @click="" icon='el-icon-menu'></el-button>
            </div>
        </div>
        <div class="flex m-1 flex-col h-full  overflow-hidden flex-1">
            <codemirror
                v-model="code"
                placeholder="Code goes here..."
                :disabled="true"
                :extensions="extensions"
                @ready="handleReady"
            />
        </div>
        <div class="flex m-1 h-f10 flex-row">
            <el-button class="flex" size="small" @click="" icon='el-icon-video-play'></el-button>
            <el-button class="flex" size="small" @click="" icon='el-icon-video-pause'></el-button>
        </div>
    </div>
</template>
<script lang="ts" setup>
import { ref, onMounted, shallowRef } from 'vue'
import { Codemirror } from 'vue-codemirror'
import { oneDark } from '@codemirror/theme-one-dark'
import {EditorView } from "codemirror"

const search_input = ref('')
const query_input = ref('')
const custom_script = ref('')
const options = [
    {
        value: '1',
        label: 'Option 1'
    },
    {
        value: '2',
        label: 'Option 2'
    }
]

var code = ref(`console.log('Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')Hello, world!')\n`)

const extensions = [ 
    EditorView.lineWrapping, 
    EditorView.domEventHandlers({
    click: (event, view) => {
        console.log(event)
        let cursor = view.state.selection.main.head;
        let line = view.state.doc.lineAt(cursor);
        let row = line.number;
        let col = cursor - line.from;
        console.log("line = " + row + " col = " + col);
        alert(view.state.doc.line(row).text)
    },
})] // [oneDark, EditorView.lineWrapping]
const view = shallowRef()
const handleReady = (payload) => {
    view.value = payload.view
}

const myaleret = (msg) => {
    alert(msg)
}

onMounted(() => {
    for(let i=0; i<100; i++){
        code.value += `console.log('Hello, world!')\n`
    }
   
})

</script>

<style>
/* 设置日志空间垂直滚动 */
.cm-editor {
    height: 100%;
}
.cm-scroller {
    overflow: "scroll";
    height: "100%"
}

.el-tabs__header { 
  height: 28px !important;  /* 设定目标高度 */
}

/* 调整导航标签项高度 */
.el-tabs__nav {
  height: 100%;             /* 继承父容器高度 */
}
 
/* 单个标签项高度适配 */
.el-tabs__item {
  height: 100%;            /* 继承导航栏高度 */
  line-height: 28px !important; /* 垂直居中 */
  padding: 0 20px !important;  /* 调整左右间距 */
}

.wildcarc_pattern .el-checkbox-button__inner {
    padding-left: 4px;
    padding-right: 4px;
}
</style>