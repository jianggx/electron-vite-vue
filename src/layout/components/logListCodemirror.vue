<template>
            <codemirror
                v-model="code"
                placeholder="Code goes here..."
                :disabled="true"
                :extensions="extensions"
                @ready="handleReady"
            />
</template>

<script lang="ts" setup>
import { ref, onMounted, shallowRef } from 'vue'
import { Codemirror } from 'vue-codemirror'
import { oneDark } from '@codemirror/theme-one-dark'
import {EditorView, basicSetup } from "codemirror"
import { html } from "@codemirror/lang-html";


const logExamples = ["2025-06-21 14:30:05, [DEBUG]traceFlag=unilog, msgType=FrameHead, msgSn=123456789, CupId=987654321, frameType=0, toolId=tool123, reserved1=0, reserved2=0",
                     "2025-06-21 14:30:05, [ERROR]get unexpected msgType=TraceHead",
                     "2025-06-21 14:30:05, [ERROR]failed to get the device info.",
                     "2025-06-21 14:30:05, [ERROR]get unexpected msgType=TraceHead",
                     "2025-06-21 14:30:05, [DEBUG]send the message in 2ms.",
                     "2025-06-21 14:30:05, [DEBUG]traceFlag=unilog, msgType=FrameHead, msgSn=123456789, CupId=987654321, frameType=0, toolId=tool123, reserved1=0",
]

var code = ref("")

import { StreamLanguage, StringStream } from "@codemirror/language"
import { indentUnit } from "@codemirror/language"

// 自定义词法规则 (示例：高亮自定义关键字)
const customLexer = {
  token: (stream: StringStream) => {
    if (stream.match("ERROR"))  return "keyword";
    if (stream.match("DEBUG"))  return "variable";
    stream.next(); 
    return null;
  }
};


const customSyntax = StreamLanguage.define(customLexer); 
const customMode = [
  customSyntax,
  indentUnit.of("   ")  // 缩进规则 
];

const customTheme = EditorView.theme({ 
  ".cm-keyword-custom": { color: "#FF6B6B", fontWeight: "bold" },
  ".cm-variable": { color: "#4ECDC4" }
});


const extensions = [ 
    customMode,
    //customTheme,
    basicSetup,
    //EditorView.lineWrapping, 
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
const handleReady = (payload: any) => {
    view.value = payload.view
}

onMounted(() => {
    for(let i=0; i<100; i++){
        code.value += (logExamples[Math.floor(Math.random()  * logExamples.length)] + "\n");
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
</style>