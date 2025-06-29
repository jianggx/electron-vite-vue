<template>
    <div class="flex flex-row">
        <div class="w-1/2 flex flex-row">
            <div class="flex-1"></div>
            <div class="flex flex-col">
                <div class="h-4"></div>
                项目：
                <div class="flex flex-col"> 
                    <el-link class="ml-5 w-fit" @click="" type="primary" underline="always">新建项目</el-link>
                    <el-link class="ml-5 w-fit" @click="" type="primary" underline="always">打开项目</el-link>
                    <el-link class="ml-5 w-fit" @click="" type="primary" underline="always">打开设备</el-link>
                    <el-link class="ml-5 w-fit" @click="" type="primary" underline="always">导入日志</el-link>
                </div>
                <div class="h-4"></div>
                最近项目：
                <div class="flex flex-col"> 
                    <el-link class="ml-5 w-fit" @click="" type="primary" underline="always">jgx-abc</el-link>  
                </div>              
            </div>
            <div class="flex-1"></div>
        </div>
        <div class="w-1/2 flex flex-row">
            <div class="flex flex-col">
                <div class="h-4"></div>
                帮助：
                <div class="flex flex-col align-start"> 
                    <el-link class="ml-5 w-fit" @click="" type="primary" underline="always">使用指南...</el-link>
                    <el-link class="ml-5 w-fit" @click="" type="primary" underline="always">高级搜索指南...</el-link>
                    <el-link class="ml-5 w-fit" @click="" type="primary" underline="always">正则表达式...</el-link>
                </div>
                <div class="h-4"></div>
                常见问题:
                <div class="flex flex-col"> 
                    <el-link class="ml-5 w-fit" @click="" type="primary" underline="always">是否支持多设备同时打开？</el-link>  
                </div>              
            </div>
            <div class="flex-1"></div>            
        </div>
    </div>
    <h1> {{ greeter }}</h1>
</template>
<script lang="ts" setup>
import { ref } from 'vue'
import {sayHello, setTitle} from '/@/api/electron'

const greeter = ref('')

const set_title = () => {
    setTitle('asdb')
} 

async function say_hello() {
    let ret = await sayHello("gavin")
    greeter.value += ret
}

</script>