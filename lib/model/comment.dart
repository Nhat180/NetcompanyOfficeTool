class Comment {
final String creator;
final String type;
final String cmt;
final String imgUrl;


const Comment({
required this.creator,
required this.type,
required this.cmt,
required this.imgUrl,
});
}

const allComments =[
  Comment(creator: "pct", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "pct", type: "text", cmt: "Hello this is my dog asdn dansdh  sadhas hdmsd asdnaslkdhas ds dashdsnddalddha hashdasn  sodhoasd ladhoaisdn as dolishdand dasldhj   dadkhs  ", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "worse", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "worse", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "worse", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "wll", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "admin", type: "text", cmt: "Well is quite cute", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "thanks", imgUrl: ""),
  Comment(creator: "admin", type: "image", cmt: "", imgUrl: "https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp"),
  Comment(creator: "admin", type: "text", cmt: "how about my cat", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "nice", imgUrl: ""),
  Comment(creator: "pct", type: "text", cmt: "adsdas", imgUrl: ""),


];