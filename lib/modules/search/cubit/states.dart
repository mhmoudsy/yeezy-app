abstract class SearchStates{}
class SearchInitialState extends SearchStates{}
class ProductSearchLoadingState extends SearchStates{}
class ProductSearchSuccessState extends SearchStates{


}
class ProductSearchErrorState extends SearchStates{
  final String error;


  ProductSearchErrorState(this.error);
}
class PopState extends SearchStates{}

