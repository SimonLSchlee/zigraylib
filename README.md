# zigraylib
A fairly minimal [raylib](https://www.raylib.com/) [zig](https://ziglang.org/download/) example codebase using the zig package manager.

This example requires one of the recent development releases of zig.

## install

```bash
git clone https://github.com/SimonLSchlee/zigraylib.git
cd zigraylib
zig build run
```

Tested with zig version: `0.14.0-dev.2+0884a4341`  
Using raylib commit: https://github.com/raysan5/raylib/tree/52f2a10db610d0e9f619fd7c521db08a876547d0

Note: If you don't have zig installed yet, I recommend using [zvm](https://www.zvm.app/) to help with installation. It also provides correct version of ZLS (Zig Language Server) that is compatible with the appropriate version. For example use `zvm i --zls master` to install the latest master with zls.

### Live error checking

This project has been configured so that ZLS can show live compile errors on save. To make it work, you need to set these zls config params (in VSCode just copy these to your preferences):
```
    "zig.zls.enableBuildOnSave": true,
    "zig.zls.buildOnSaveStep": "check"
```

Also, if you're in VSCode, install ErrorLens extension so you can see the errors inline.

## resources
[raylib cheatsheet](https://www.raylib.com/cheatsheet/cheatsheet.html)  
[Learn ⚡ Zig Programming Language](https://ziglang.org/learn/)  
[Zig Community](https://github.com/ziglang/zig/wiki/Community)  

## code completion
[zls installation](https://github.com/zigtools/zls/wiki/Installation)

## ideas or improvements?
Let me know if you have ideas about things that could make this example better.
I want to keep it fairly minimal, but maybe we can add some more links to useful resources, or point out common problems.
Ziggit topic for discussion: https://ziggit.dev/t/raylib-example-using-the-package-manager/1787

## license
public domain or MIT
