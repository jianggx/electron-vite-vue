<template>
    <ElConfigProvider :locale='locale'>
        <router-view />
    </ElConfigProvider>
</template>

<script lang='ts'>
import { defineComponent, ref, Ref, watch } from 'vue'
import locale from 'element-plus/es/locale/lang/zh-cn'
import { ElConfigProvider } from 'element-plus'
import { useLayoutStore } from '/@/store/modules/layout'

export default defineComponent ({
    name: 'App',
    components: {
        ElConfigProvider
    },
    setup() {
        const { getSetting } = useLayoutStore()

        return {
            locale,
            getSetting
        }
    }
})
</script>

<style lang='postcss'>

</style>