## input-view-height
- UITextView.inputView를 custom view로 바꿨다가 다시 키보드로 돌아갈 때, inputAccessoryView가 제대로 표시되지 않는 문제.
- 매번 inputAccessoryView를 assign하라고. inputAccessoryView를 assign하니 keyboardWillShow도 매번 발생함.
- [https://openradar.appspot.com/43081635](https://openradar.appspot.com/43081635)

