
export function setTitle(title:string) {
    window.electronAPI.setTitle(title)
} 

export async function sayHello(name:string):Promise<string> {
    return await window.electronAPI.sayHello(name)
}