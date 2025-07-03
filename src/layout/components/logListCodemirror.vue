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


const logExamples = ["FrameHead: msgType=trace,\tframeType=entire,\tCupId=0,\ttoolId=12;\t"+
                            "TraceHead:\tmodId=PHY,\ttraceLevel=Debug,\ttimeStamp=2025-06-21 14:30:05,\ttraceFlag=unilog,\n"
                      ,"FrameHead: msgType=diag,\tframeType=entire,\tCupId=0,\ttoolId=12;\t"+
                        "DiagLogHead:\tsrcTaskId=11(tABC),\tsrcProcId=113(POCC_EE),\tdestTaskId=11(tABC),\tdestProcId=113(POCC_EE),\tsapId=2(AED_AEE),\tprimId=22323(STEE_SFSDFS_EEEE_PROCC)\tmessageName=DED_EE_YUIG\ttimeStamp=2025-06-21 14:30:05\n"
                    ]

var code = ref("")

import { StreamLanguage, StringStream } from "@codemirror/language"
import { indentUnit } from "@codemirror/language"

// 自定义词法规则 (示例：高亮自定义关键字)
const customLexer = {
  token: (stream: StringStream) => {
    if (stream.match("FrameHead"))  return "keyword";
    if (stream.match("msgType"))  return "keyword";
    if (stream.match("msgSn"))  return "keyword";
    if (stream.match("CupId"))  return "keyword";
    if (stream.match("frameType"))  return "keyword";
    if (stream.match("toolId"))  return "keyword";
    if (stream.match("TraceHead"))  return "keyword";
    if (stream.match("modId"))  return "keyword";
    if (stream.match("timeStamp"))  return "keyword";
    if (stream.match("traceFlag"))  return "keyword";
    if (stream.match("reserved1"))  return "keyword";
    if (stream.match("reserved2"))  return "keyword";
    if (stream.match("DiagLogHead"))  return "keyword";
    if (stream.match("srcTaskId"))  return "keyword";
    if (stream.match("srcProcId"))  return "keyword";
    if (stream.match("destTaskId"))  return "keyword";
    if (stream.match("destProcId"))  return "keyword";
    if (stream.match("sapId"))  return "keyword";
    if (stream.match("primId"))  return "keyword";
    if (stream.match("messageName"))  return "keyword";
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
        code.value += logExamples[Math.floor(Math.random()  * logExamples.length)]
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