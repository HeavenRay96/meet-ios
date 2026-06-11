import Foundation

// MARK: - Mock 数据
struct MockData {
    
    // MARK: - 用户
    static let users: [MeetUser] = [
        MeetUser(id: 1, nickname: "山海旅人", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_1", bio: "走遍中国大好河山", travelCount: 42, followerCount: 128, followingCount: 56),
        MeetUser(id: 2, nickname: "背包客小陈", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_2", bio: "用脚步丈量世界", travelCount: 38, followerCount: 96, followingCount: 42),
        MeetUser(id: 3, nickname: "摄影师阿杰", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_3", bio: "镜头里的风景", travelCount: 56, followerCount: 256, followingCount: 89),
        MeetUser(id: 4, nickname: "城市漫游者", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_4", bio: "发现城市角落的美", travelCount: 28, followerCount: 67, followingCount: 34),
        MeetUser(id: 5, nickname: "骑行爱好者小王", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_5", bio: "两轮丈量大地", travelCount: 35, followerCount: 82, followingCount: 45),
        MeetUser(id: 6, nickname: "美食探险家", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_6", bio: "舌尖上的旅行", travelCount: 63, followerCount: 189, followingCount: 73),
        MeetUser(id: 7, nickname: "星空观测者", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_7", bio: "追逐银河的人", travelCount: 21, followerCount: 145, followingCount: 38),
        MeetUser(id: 8, nickname: "潜水达人", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_8", bio: "海底两万里", travelCount: 47, followerCount: 112, followingCount: 51),
        MeetUser(id: 9, nickname: "徒步旅行者", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_9", bio: "一步一步看世界", travelCount: 31, followerCount: 78, followingCount: 29),
        MeetUser(id: 10, nickname: "文化探索者", avatarURL: "https://api.dicebear.com/7.x/thumbs/svg?seed=user_10", bio: "触摸历史的温度", travelCount: 44, followerCount: 93, followingCount: 47),
    ]
    
    // MARK: - 帖子
    static let posts: [TravelPost] = [
        TravelPost(id: 1, userId: 1, title: "大理洱海骑行日记", content: "今天沿着洱海骑行了一整天，从才村出发，经过喜洲古镇，最后到达双廊。沿途的风景美不胜收，蓝天白云倒映在洱海中，像一幅流动的画卷。", location: "大理·洱海", coverURL: "https://picsum.photos/seed/post_1/800/600", imageURLs: (0..<4).map { "https://picsum.photos/seed/post_1_\($0)/800/600" }, likeCount: 42, commentCount: 8, createdAt: "2026-06-10T10:30:00Z", user: users[0], isLiked: false, isBookmarked: false),
        TravelPost(id: 2, userId: 2, title: "稻城亚丁——蓝色星球上的最后一片净土", content: "终于来到了传说中的稻城亚丁。牛奶海的颜色真的像牛奶一样纯净，五色海在阳光下闪耀着不同的色彩，仿佛上帝打翻了调色盘。", location: "四川·稻城亚丁", coverURL: "https://picsum.photos/seed/post_2/800/600", imageURLs: (0..<5).map { "https://picsum.photos/seed/post_2_\($0)/800/600" }, likeCount: 128, commentCount: 24, createdAt: "2026-06-09T14:20:00Z", user: users[1], isLiked: true, isBookmarked: false),
        TravelPost(id: 3, userId: 3, title: "黄山云海日出", content: "凌晨四点起床，摸黑爬上光明顶。当第一缕阳光穿透云海，整个黄山被染成金色，所有的疲惫都值得了。", location: "安徽·黄山", coverURL: "https://picsum.photos/seed/post_3/800/600", imageURLs: (0..<3).map { "https://picsum.photos/seed/post_3_\($0)/800/600" }, likeCount: 89, commentCount: 15, createdAt: "2026-06-08T06:15:00Z", user: users[2], isLiked: false, isBookmarked: true),
        TravelPost(id: 4, userId: 4, title: "上海外滩夜景", content: "夜幕降临，外滩的万国建筑群亮起灯光，黄浦江对岸的陆家嘴灯火辉煌。这座城市的魅力在夜晚完全绽放。", location: "上海·外滩", coverURL: "https://picsum.photos/seed/post_4/800/600", imageURLs: (0..<3).map { "https://picsum.photos/seed/post_4_\($0)/800/600" }, likeCount: 56, commentCount: 11, createdAt: "2026-06-07T20:30:00Z", user: users[3], isLiked: false, isBookmarked: false),
        TravelPost(id: 5, userId: 5, title: "环青海湖骑行挑战", content: "四天环湖360公里，经历了高原的烈日、狂风和暴雨，但青海湖的美让我忘记了所有疲惫。茶卡盐湖的天空之镜更是绝美。", location: "青海·青海湖", coverURL: "https://picsum.photos/seed/post_5/800/600", imageURLs: (0..<4).map { "https://picsum.photos/seed/post_5_\($0)/800/600" }, likeCount: 73, commentCount: 19, createdAt: "2026-06-06T09:00:00Z", user: users[4], isLiked: true, isBookmarked: true),
        TravelPost(id: 6, userId: 6, title: "成都美食地图", content: "在成都待了一周，从早吃到晚。火锅、串串、担担面、龙抄手、三大炮...每一样都让人回味无穷。成都，一座来了就不想走的城市。", location: "四川·成都", coverURL: "https://picsum.photos/seed/post_6/800/600", imageURLs: (0..<5).map { "https://picsum.photos/seed/post_6_\($0)/800/600" }, likeCount: 95, commentCount: 31, createdAt: "2026-06-05T12:30:00Z", user: users[5], isLiked: false, isBookmarked: false),
        TravelPost(id: 7, userId: 7, title: "腾格里沙漠星空", content: "在腾格里沙漠深处，远离城市光污染，银河清晰可见。躺在沙丘上数流星，这是最浪漫的夜晚。", location: "宁夏·腾格里沙漠", coverURL: "https://picsum.photos/seed/post_7/800/600", imageURLs: (0..<3).map { "https://picsum.photos/seed/post_7_\($0)/800/600" }, likeCount: 67, commentCount: 12, createdAt: "2026-06-04T22:00:00Z", user: users[6], isLiked: true, isBookmarked: false),
        TravelPost(id: 8, userId: 8, title: "三亚蜈支洲岛潜水", content: "蜈支洲岛的海水清澈见底，珊瑚礁五彩斑斓，热带鱼群在身边游来游去。海底世界比想象中还要美。", location: "海南·三亚", coverURL: "https://picsum.photos/seed/post_8/800/600", imageURLs: (0..<4).map { "https://picsum.photos/seed/post_8_\($0)/800/600" }, likeCount: 81, commentCount: 16, createdAt: "2026-06-03T15:45:00Z", user: users[7], isLiked: false, isBookmarked: true),
        TravelPost(id: 9, userId: 9, title: "雨崩村徒步", content: "徒步走进雨崩村，穿过原始森林，翻越海拔3800米的垭口。当梅里雪山出现在眼前的那一刻，所有的艰辛都化作了感动。", location: "云南·雨崩", coverURL: "https://picsum.photos/seed/post_9/800/600", imageURLs: (0..<5).map { "https://picsum.photos/seed/post_9_\($0)/800/600" }, likeCount: 112, commentCount: 22, createdAt: "2026-06-02T08:00:00Z", user: users[8], isLiked: true, isBookmarked: true),
        TravelPost(id: 10, userId: 10, title: "敦煌莫高窟", content: "莫高窟的壁画和彩塑让人震撼，一千年前的工匠们用画笔记录下了那个时代的信仰与生活。每一幅壁画都是一个故事。", location: "甘肃·敦煌", coverURL: "https://picsum.photos/seed/post_10/800/600", imageURLs: (0..<3).map { "https://picsum.photos/seed/post_10_\($0)/800/600" }, likeCount: 48, commentCount: 9, createdAt: "2026-06-01T11:20:00Z", user: users[9], isLiked: false, isBookmarked: false),
        TravelPost(id: 11, userId: 1, title: "西湖晨雾", content: "清晨六点的西湖，湖面笼罩着一层薄雾，远处的雷峰塔若隐若现。断桥上的行人稀少，只有几只水鸟在湖面划过。", location: "杭州·西湖", coverURL: "https://picsum.photos/seed/post_11/800/600", imageURLs: (0..<3).map { "https://picsum.photos/seed/post_11_\($0)/800/600" }, likeCount: 34, commentCount: 5, createdAt: "2026-05-30T06:30:00Z", user: users[0], isLiked: false, isBookmarked: false),
        TravelPost(id: 12, userId: 3, title: "故宫的雪", content: "北京下雪了，故宫变成了紫禁城。红墙白雪，琉璃瓦上覆盖着厚厚的积雪，美得像一幅水墨画。", location: "北京·故宫", coverURL: "https://picsum.photos/seed/post_12/800/600", imageURLs: (0..<4).map { "https://picsum.photos/seed/post_12_\($0)/800/600" }, likeCount: 156, commentCount: 28, createdAt: "2026-05-28T10:00:00Z", user: users[2], isLiked: true, isBookmarked: true),
        TravelPost(id: 13, userId: 5, title: "桂林漓江竹筏", content: "乘竹筏顺漓江而下，两岸青山如画，江水清澈见底。二十元人民币背面的风景就在眼前。", location: "广西·桂林", coverURL: "https://picsum.photos/seed/post_13/800/600", imageURLs: (0..<3).map { "https://picsum.photos/seed/post_13_\($0)/800/600" }, likeCount: 62, commentCount: 13, createdAt: "2026-05-26T14:00:00Z", user: users[4], isLiked: false, isBookmarked: false),
        TravelPost(id: 14, userId: 7, title: "西藏纳木错", content: "纳木错，藏语意为"天湖"。海拔4718米，是世界上海拔最高的咸水湖。湖水蓝得不可思议，远处的念青唐古拉山白雪皑皑。", location: "西藏·纳木错", coverURL: "https://picsum.photos/seed/post_14/800/600", imageURLs: (0..<4).map { "https://picsum.photos/seed/post_14_\($0)/800/600" }, likeCount: 134, commentCount: 26, createdAt: "2026-05-24T07:30:00Z", user: users[6], isLiked: true, isBookmarked: true),
        TravelPost(id: 15, userId: 9, title: "张家界玻璃栈道", content: "站在张家界玻璃栈道上，脚下就是万丈深渊。虽然知道玻璃很安全，但走上去还是腿软。不过风景是真的绝了！", location: "湖南·张家界", coverURL: "https://picsum.photos/seed/post_15/800/600", imageURLs: (0..<3).map { "https://picsum.photos/seed/post_15_\($0)/800/600" }, likeCount: 77, commentCount: 18, createdAt: "2026-05-22T16:00:00Z", user: users[8], isLiked: false, isBookmarked: false),
    ]
    
    // MARK: - 评论
    static func comments(for postId: Int) -> [Comment] {
        let commentTexts = [
            "好美！下次一定要去！",
            "这是哪里呀，求攻略🙏",
            "拍得太棒了！用的什么相机？",
            "我也去过，真的很值得！",
            "收藏了，列入旅行清单✅",
            "这个季节去最合适了",
            "太震撼了，感谢分享✨",
            "请问需要门票吗？",
            "和朋友们一起去一定很开心",
            "照片拍出了灵魂👍",
        ]
        return (0..<Int.random(in: 3...6)).map { i in
            Comment(
                id: i + 1,
                user: users[(postId + i) % users.count],
                content: commentTexts[i % commentTexts.count],
                createdAt: "2026-06-\(String(format: "%02d", Int.random(in: 1...11)))T\(String(format: "%02d", Int.random(in: 8...22))):00:00Z"
            )
        }
    }
    
    // 获取热门帖子（用于浮卡）
    static var hotPost: TravelPost {
        posts.max(by: { $0.likeCount + $0.commentCount < $1.likeCount + $1.commentCount }) ?? posts[0]
    }
    
    // 活跃用户头像
    static var activeUserAvatars: [String] {
        Array(users.shuffled().prefix(3)).map { $0.avatarURL }
    }
}
