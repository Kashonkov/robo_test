abstract class ListEvent {
  const ListEvent();
}

class OnInitialEvent extends ListEvent{}

class OnRefreshEvent extends ListEvent{}

class OnQueryChangeEvent extends ListEvent{
  final String? query;

  OnQueryChangeEvent(this.query);
}
