function showNotice(title, text) {
  var opts = {
    title: title,
    text: text,
    type: "success",
    addclass: "stack-topright",
    stack: stack_topright,
    delay: 1500
  };
  $pnotify(opts);
}
