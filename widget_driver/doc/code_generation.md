# Code Generation

The `WidgetDriver` framework uses `TestDrivers` as a replacement for your real `Drivers` when you are running widgetTests.

To be able to create these `TestDrivers` the `WidgetDriver` framework uses code generation.

The code generation outputs two things for each `Driver`:

- A `TestDriver`:  
The driver replacement with hard coded default values, provided via the `annotations`.
- A `WidgetDriverProvider`:  
An object that knows how to create your `Driver` and `TestDriver`.

## Why is code generation needed

Well actually you don't need it. You can easily write the `TestDriver` and `WidgetDriverProvider` manually. But as your app grows this gets more and more painful. And it is error prone since you might easily make a small mistake.

That is why we added the code generation process.  
It just makes your life easier.

Also, the `TestDriver` and `WidgetDriverProvider` don't contain any of your business logic. So you don't really care about their implementation. You just want them to be there.

## How do you generate the code?

This is pretty easy. It basically just contains two steps:

1. Add the correct `dev_dependencies`. You need:  
    ```yaml
    dev_dependencies:
        <Your other dev dependencies>
        build_runner: <latest-version>
        widget_driver_generator: <latest-version>
    ```

2. Run the build runner:  
    ```console
    dart run build_runner build --delete-conflicting-outputs
    ```
    Read more about using the `build_runner` [here](https://pub.dev/packages/build_runner).
