# WidgetDriver - example app

This is an example app that showcases how you can use the WidgetDriver framework.  

It is a fairly advanced example app that tries to replicate a real app scenario.

Many of these example apps just demonstrates a non-real use-case where you store app state directly in the view/view-model/bloc.

This can be confusing since it guides developes to put their important business logic state directly in the view/view-model/bloc.

Therefore this app tries to act like a real life application. With business logic and state places inside a service layer. The presentation layer then consumes these services.

---

## Preview of the app

<p>
<img src="doc/resources/example_app_demo_1.gif?raw=true"
height="400"/>
&nbsp;&nbsp;&nbsp;&nbsp;
<img src="doc/resources/example_app_demo_2.gif?raw=true"
height="400"/>
</p>

## App architecture

The app is using the `WidgetDrivers` to drive the widgets.  
The `Drivers` don't keep any state themselves. They get their data from a service layer and then use/combine these to drive and update the widgets.

The app uses two approaches to provide dependencies to the `Drivers`.  
The reason for this is to showcase that you go either way. Just pick the path which works best for your project.

If you prefer passing dependencies via the BuildContext then go that path.
Or if you like using some Dependency injection framework then that path works just as good.

The example app will show you how to use both approaches.

## Testing

The example app also showcases how you can test your widgets and `Drivers`. Check out the existing tests [here](test) to get inspiration on how you can set up your tests.
