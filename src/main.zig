const std = @import("std");
const ray = @import("raylib.zig");

pub fn main() !void {
    try ray_main();
    try old_main(); // remove this if you don't need it
    try hints();
}

fn ray_main() !void {
    // const monitor = ray.GetCurrentMonitor();
    // const width = ray.GetMonitorWidth(monitor);
    // const height = ray.GetMonitorHeight(monitor);
    const width = 800;
    const height = 450;

    ray.SetConfigFlags(ray.FLAG_MSAA_4X_HINT | ray.FLAG_VSYNC_HINT);
    ray.InitWindow(width, height, "zig raylib example");
    defer ray.CloseWindow();

    var gpa = std.heap.GeneralPurposeAllocator(.{ .stack_trace_frames = 8 }){};
    const allocator = gpa.allocator();
    defer {
        switch (gpa.deinit()) {
            .leak => @panic("leaked memory"),
            else => {},
        }
    }

    const colors = [_]ray.Color{ ray.GRAY, ray.RED, ray.GOLD, ray.LIME, ray.BLUE, ray.VIOLET, ray.BROWN };
    const colors_len: i32 = @intCast(colors.len);
    var current_color: i32 = 2;
    var hint = true;

    const rec = ray.Rectangle{ .x = 600, .y = 40, .width = 120, .height = 20 };
    var value: f32 = 0;

    while (!ray.WindowShouldClose()) {
        // input
        var delta: i2 = 0;
        if (ray.IsKeyPressed(ray.KEY_UP)) delta += 1;
        if (ray.IsKeyPressed(ray.KEY_DOWN)) delta -= 1;
        if (delta != 0) {
            current_color = @mod(current_color + delta, colors_len);
            hint = false;
        }

        // draw
        {
            ray.BeginDrawing();
            defer ray.EndDrawing();

            ray.ClearBackground(colors[@intCast(current_color)]);
            if (hint) ray.DrawText("press up or down arrow to change background color", 120, 140, 20, ray.BLUE);
            ray.DrawText("Congrats! You created your first window!", 190, 200, 20, ray.BLACK);

            // now lets use an allocator to create some dynamic text
            // pay attention to the Z in `allocPrintZ` that is a convention
            // for functions that return zero terminated strings
            const seconds: u32 = @intFromFloat(ray.GetTime());
            const dynamic = try std.fmt.allocPrintZ(allocator, "running since {d} seconds", .{seconds});
            defer allocator.free(dynamic);
            ray.DrawText(dynamic, 300, 250, 20, ray.WHITE);

            _ = ray.GuiSliderBar(rec, "StartAngle", null, &value, -450, 450);

            ray.DrawFPS(width - 100, 10);
        }
    }
}

// remove this function if you don't need it
fn old_main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

fn hints() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("\n⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯\n", .{});
    try stdout.print("Here are some hints:\n", .{});
    try stdout.print("Run `zig build --help` to see all the options\n", .{});
    try stdout.print("Run `zig build -Doptimize=ReleaseSmall` for a small release build\n", .{});
    try stdout.print("Run `zig build -Doptimize=ReleaseSmall -Dstrip=true` for a smaller release build, that strips symbols\n", .{});
    try stdout.print("Run `zig build -Draylib-optimize=ReleaseFast` for a debug build of your application, that uses a fast release of raylib (if you are only debugging your code)\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
