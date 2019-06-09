# How to Make the scroll of a TableView inside TableView behave naturally
> Just sample, just a note, just for fun

As shown in the next image, the main view is a UITableView. Then inside it should have a UIPageView, and each page of the PageView should have a UITableView.

<img width="600" src="/Image/sample_image01.jpg"></img>


# Result image (GIF)

<img width="500" src="/Image/result_image01.gif"></img>

# Other comments
- If you have the same type, let's think about creating it with [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview).

# Reference link
- Issue : [container views cannot be placed in elements that are repeated at runtime](https://stackoverflow.com/questions/21345629/ios-container-view-in-uitableviewcell/38673948)