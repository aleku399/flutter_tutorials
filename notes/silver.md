Columns are laid out depending on the height and width of devices.

List Items  that are large than the screen will overthrow if out only in column but if we use SingleChildScrollView or ListItem builder our list items will be built on demand.

**SliverAPPBar**

pinned: stays sticker

floating: the app bar scrolls out of view but comes back when a user stops scrolling

snap: it scrolls away when i stop scrolling it comes back with animation

expandedHeight: can do combinations with pinned, floating and snap

**flexibleSpace: FlexibleSpaceBar**

allows us to fill the **expandedHeight** in our SliverAppBar

**collapseMode**

detects how the content add in the flexibleSpace will scroll

CollapseMode.parallax - it collapses int the app bar

CollapseMode.pin - it stay sticker when user scrolls

**property stretch**

set true can help us refresh data using callback **onStretchTrigger**