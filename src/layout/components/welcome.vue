<template>
    <div class="welcome">
    <el-button @click="set_title">set title</el-button>
    <el-button @click="say_hello">say hello</el-button>
    <h1> {{ greeter }}</h1>
  </div>
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