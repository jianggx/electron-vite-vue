
export function setTitle(title:string) {
    window.ipcRenderer.setTitle(title)
} 

export async function sayHello(name:string):Promise<string> {
    return await window.ipcRenderer.sayHello(name)
}