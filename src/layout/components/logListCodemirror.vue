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

import { StreamLanguage } from "@codemirror/language"
import { indentUnit } from "@codemirror/language"

// 自定义词法规则 (示例：高亮自定义关键字)
const customLexer = {
  token: (stream) => {
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

import { Decoration } from '@codemirror/view';
import { StateEffect } from '@codemirror/state';

// 定义一个装饰效果，用于添加或替换装饰
const addLineDecoration = StateEffect.define(); 
// 函数：根据条件（比如行内容）计算装饰集
function computeDecorations(view) {
  let decorations = [];
  // 遍历每一行
  for (let { from, to } of view.visibleRanges)  {
    for (let pos = from; pos <= to; ) {
      let line = view.state.doc.lineAt(pos); 
      // 如果该行包含“error”，则添加装饰
      if (line.text.includes('msgType=trace'))  {
        // 创建行装饰，注意：行装饰是从行开头到行末尾（不包括行尾换行符）
        let deco = Decoration.line({ 
          attributes: { class: 'error-line' }
        });
        decorations.push(deco.range(line.from)); 
      }
      pos = line.to  + 1;
    }
  }
  return Decoration.set(decorations); 
}

// 扩展：当文档或视图变化时，重新计算装饰
const dynamicLineDecorator = EditorView.updateListener.of(update  => {
  if (update.docChanged  || update.viewportChanged)  {
    let view = update.view; 
    let decorations = computeDecorations(view);
    // 使用事务效果更新装饰
    view.dispatch({ 
      effects: addLineDecoration.of(decorations) 
    });
  }
});

// 将上述扩展组合起来
const customTheme2 = EditorView.baseTheme({ 
  '.error-line': { backgroundColor: '#ff00004d' } // 半透明红色背景
});

const lineHighlighter = [
  dynamicLineDecorator,
  customTheme2
];



const extensions = [ 
    customMode,
    //customTheme,
    basicSetup,
    lineHighlighter,
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
const handleReady = (payload) => {
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