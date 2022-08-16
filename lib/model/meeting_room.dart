class MeetingRoom {
  final String name;
  final String floor;
  final int capacity;
  final double coordinatorX;
  final double coordinatorY;
  final String imgUrl;
  final List<String> equipment;


  const MeetingRoom({
    required this.name,
    required this.floor,
    required this.capacity,
    required this.coordinatorX,
    required this.coordinatorY,
    required this.imgUrl,
    required this.equipment
  });
}

const allMeetingRooms =[
  MeetingRoom(name: "Da Lat", floor: "Floor 24", capacity: 8, coordinatorY: 30, coordinatorX: 50, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Hue", floor: "Floor 24", capacity: 4, coordinatorY: -300, coordinatorX: -345, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Ha Noi", floor: "Floor 24", capacity: 10, coordinatorY: -300, coordinatorX: 55, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Can Tho", floor: "Floor 24", capacity: 6, coordinatorY: -100, coordinatorX: -80, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Nha Trang", floor: "Floor 24", capacity: 4, coordinatorY: 310, coordinatorX: 55, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Ha Long", floor: "Floor 24", capacity: 1, coordinatorY: 265, coordinatorX: -460, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Phu Quoc", floor: "Floor 24", capacity: 1, coordinatorY: 280, coordinatorX: -350, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Esbjerg", floor: "Floor 25", capacity: 4, coordinatorY: 310, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Aalborg", floor: "Floor 25", capacity: 4, coordinatorY: -315, coordinatorX: -330, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Copenhagen", floor: "Floor 25", capacity: 4, coordinatorY: -10, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Odense", floor: "Floor 25", capacity: 10, coordinatorY: -340, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Kolding", floor: "Floor 25", capacity: 1, coordinatorY: 280, coordinatorX: -350, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Randers", floor: "Floor 25", capacity: 1, coordinatorY: 265, coordinatorX: -460, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Aarhus", floor: "Floor 25", capacity: 1, coordinatorY: -200, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Ho Chi Minh City", floor: "Floor 26", capacity: 42, coordinatorY: -300, coordinatorX: 15, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Drammen", floor: "Floor 27", capacity: 4, coordinatorY: -315, coordinatorX: -330, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Skien", floor: "Floor 27", capacity: 1, coordinatorY: 265, coordinatorX: -460, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Stavanger", floor: "Floor 27", capacity: 10, coordinatorY: -340, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Trondheim", floor: "Floor 27", capacity: 4, coordinatorY: 310, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Fredrikstad", floor: "Floor 27", capacity: 1, coordinatorY: 280, coordinatorX: -350, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Oslo", floor: "Floor 27", capacity: 4, coordinatorY: -200, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Bergen", floor: "Floor 27", capacity: 4, coordinatorY: -10, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Birmingham", floor: "Floor 31", capacity: 4, coordinatorY: -10, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Glasgow", floor: "Floor 31", capacity: 4, coordinatorY: 310, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Leeds", floor: "Floor 31", capacity: 4, coordinatorY: -315, coordinatorX: -330, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "London", floor: "Floor 31", capacity: 10, coordinatorY: -340, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Manchester", floor: "Floor 31", capacity: 4, coordinatorY: -200, coordinatorX: 35, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Liverpool", floor: "Floor 31", capacity: 1, coordinatorY: 265, coordinatorX: -460, imgUrl: "", equipment: ["Nhat", "Hoang"]),
  MeetingRoom(name: "Southampton", floor: "Floor 31", capacity: 1, coordinatorY: 280, coordinatorX: -350, imgUrl: "", equipment: ["Nhat", "Hoang"]),
];