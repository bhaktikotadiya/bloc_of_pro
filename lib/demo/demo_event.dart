abstract class DemoEvent {}

class InitEvent extends DemoEvent {}

class sum_event extends DemoEvent
{
    String a,b;
    sum_event(this.a,this.b);
}