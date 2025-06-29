<template>
  <el-tabs
    v-model="editableTabsValue"
    type="border-card"
    editable
    @edit="handleTabsEdit"
    class="h-full"
  >
    <el-tab-pane
      key="2"
      label="welcome"
      name="welcome"
      class="h-full"
    >
      <welcome-panel />
    </el-tab-pane>
    <el-tab-pane
      key="1"
      label="sdr-1"
      name="1"
      class="h-full"
    >
      <device-panel />
    </el-tab-pane>

  </el-tabs>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import type { TabPaneName } from 'element-plus'
import WelcomePanel from '/@/layout/components/welcome.vue'
import DevicePanel from '/@/layout/components/device.vue'

let tabIndex = 2
const editableTabsValue = ref('welcome')
const editableTabs = ref([
  {
    title: 'Tab 1',
    name: '1',
    content: 'Tab 1 content',
  },
  {
    title: 'Tab 2',
    name: '2',
    content: 'Tab 2 content',
  },
])

const handleTabsEdit = (
  targetName: TabPaneName | undefined,
  action: 'remove' | 'add'
) => {
  if (action === 'add') {
    const newTabName = `${++tabIndex}`
    editableTabs.value.push({
      title: 'New Tab',
      name: newTabName,
      content: 'New Tab content',
    })
    editableTabsValue.value = newTabName
  } else if (action === 'remove') {
    const tabs = editableTabs.value
    let activeName = editableTabsValue.value
    if (activeName === targetName) {
      tabs.forEach((tab, index) => {
        if (tab.name === targetName) {
          const nextTab = tabs[index + 1] || tabs[index - 1]
          if (nextTab) {
            activeName = nextTab.name
          }
        }
      })
    }

    editableTabsValue.value = activeName
    editableTabs.value = tabs.filter((tab) => tab.name !== targetName)
  }
}
</script>

<style>
.el-tabs--border-card>.el-tabs__content {
    padding: 0px;
}

</style>
