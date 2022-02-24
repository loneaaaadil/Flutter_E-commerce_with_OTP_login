
import 'package:fluttertoast/fluttertoast.dart';

class CarouselItems{

  String images;
  String text;

  CarouselItems({this.images,this.text});
}



List caoursel=[
CarouselItems(
  images:
  'https://cdn.pixabay.com/photo/2022/02/14/12/03/craniosacral-7012994__480.jpg',
 text: 'Massage',
),
CarouselItems(
 images: 'https://cdn.pixabay.com/photo/2021/11/14/18/36/telework-6795505__340.jpg',
 text: 'Computer',
),
CarouselItems(
  images:'https://cdn.pixabay.com/photo/2021/10/31/08/34/animal-6756619__340.jpg',
 text: 'Animal',
),
CarouselItems(
 images: 'https://cdn.pixabay.com/photo/2022/02/01/11/48/woman-6986050__340.jpg',
  text:'City-baby',
),
CarouselItems(
 images: 'https://cdn.pixabay.com/photo/2022/02/14/12/03/craniosacral-7012994__480.jpg',
  text:'Baby',
),

];
//  List images=[
//     'https://cdn.pixabay.com/photo/2022/02/14/12/03/craniosacral-7012994__480.jpg',
//     'https://cdn.pixabay.com/photo/2021/11/14/18/36/telework-6795505__340.jpg',
//     'https://cdn.pixabay.com/photo/2021/10/31/08/34/animal-6756619__340.jpg',
//     'https://cdn.pixabay.com/photo/2022/02/01/11/48/woman-6986050__340.jpg',
//     'https://cdn.pixabay.com/photo/2019/07/18/17/36/nature-4346917__340.jpg',
//   ];



displayMessage(String msg){
  Fluttertoast.showToast(msg: msg);
}