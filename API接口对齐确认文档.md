# meet App — 前后端接口对齐确认文档

> **版本**: v1.0  
> **日期**: 2026-06-12  
> **编制**: iOS开发工程师  
> **后端API地址**: http://124.223.114.103/api/v1/  
> **对齐状态**: ✅ 全部确认一致

---

## 1. 通用规范

### 1.1 基础信息

| 项目 | 值 |
|------|-----|
| 开发环境baseURL | `http://localhost:8080/api/v1` |
| 生产环境baseURL | `http://124.223.114.103/api/v1` |
| 协议 | HTTP/HTTPS |
| 请求格式 | JSON |
| 响应格式 | JSON |
| 认证方式 | `Authorization: Bearer <access_token>` |

### 1.2 统一响应格式

```json
{
    "code": 0,
    "message": "success",
    "data": {},
    "request_id": "req_xxxxx"
}
```

### 1.3 错误码定义

| 错误码 | 含义 | HTTP状态码 |
|--------|------|-----------|
| 0 | 成功 | 200 |
| 1001 | 参数错误 | 400 |
| 1002 | 未授权（Token缺失/过期） | 401 |
| 1003 | 无权限 | 403 |
| 1004 | 资源不存在 | 404 |
| 1005 | 资源冲突（手机号已注册等） | 409 |
| 1006 | 验证码错误或已过期 | 400 |
| 1007 | 发送太频繁 | 429 |
| 1008 | 密码错误 | 400 |
| 2001 | 服务器内部错误 | 500 |
| 2002 | 外部服务调用失败 | 502 |

---

## 2. 认证接口 — `/api/v1/auth/*`

### 2.1 发送验证码

| 项目 | 值 |
|------|-----|
| **路径** | `POST /api/v1/auth/send-code` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

**请求体：**
```json
{
    "phone": "13800138000",
    "scene": "login"
}
```
- `scene`: `login` / `register` / `reset_password`

**响应：**
```json
{
    "code": 0,
    "message": "验证码已发送",
    "data": {
        "expire_in": 300,
        "retry_after": 60
    }
}
```

### 2.2 验证码登录

| 项目 | 值 |
|------|-----|
| **路径** | `POST /api/v1/auth/login/code` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

**请求体：**
```json
{
    "phone": "13800138000",
    "code": "123456"
}
```

**响应：**
```json
{
    "code": 0,
    "message": "登录成功",
    "data": {
        "access_token": "***",
        "refresh_token": "***",
        "expires_in": 86400,
        "user": {
            "id": 1,
            "nickname": "山海旅人",
            "avatar_url": "https://api.dicebear.com/7.x/thumbs/svg?seed=user_1",
            "phone": "138****8000"
        }
    }
}
```

### 2.3 密码登录

| 项目 | 值 |
|------|-----|
| **路径** | `POST /api/v1/auth/login/password` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

**请求体：**
```json
{
    "phone": "13800138000",
    "password": "***"
}
```

**响应：** 同验证码登录

### 2.4 注册

| 项目 | 值 |
|------|-----|
| **路径** | `POST /api/v1/auth/register` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

**请求体：**
```json
{
    "phone": "13800138000",
    "code": "123456",
    "password": "***",
    "nickname": "山海旅人"
}
```

### 2.5 忘记密码 — 验证身份

| 项目 | 值 |
|------|-----|
| **路径** | `POST /api/v1/auth/forgot-password/verify` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

**请求体：**
```json
{
    "phone": "13800138000",
    "code": "123456"
}
```

**响应：**
```json
{
    "code": 0,
    "message": "验证通过",
    "data": {
        "reset_token": "temp_reset_token_xxx",
        "expires_in": 300
    }
}
```

### 2.6 忘记密码 — 重置密码

| 项目 | 值 |
|------|-----|
| **路径** | `POST /api/v1/auth/forgot-password/reset` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

**请求体：**
```json
{
    "reset_token": "temp_reset_token_xxx",
    "new_password": "NewPass12345"
}
```

### 2.7 刷新Token

| 项目 | 值 |
|------|-----|
| **路径** | `POST /api/v1/auth/refresh` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

**请求体：**
```json
{
    "refresh_token": "***"
}
```

### 2.8 退出登录

| 项目 | 值 |
|------|-----|
| **路径** | `POST /api/v1/auth/logout` |
| **认证** | ✅ 需要 `Authorization: Bearer <access_token>` |
| **对齐状态** | ✅ |

---

## 3. 用户接口 — `/api/v1/user/*`

> 所有用户接口需认证：`Authorization: Bearer <access_token>`

### 3.1 获取个人信息

| 项目 | 值 |
|------|-----|
| **路径** | `GET /api/v1/user/profile` |
| **认证** | ✅ 需要 |
| **对齐状态** | ✅ |

**响应：**
```json
{
    "code": 0,
    "message": "success",
    "data": {
        "id": 1,
        "nickname": "山海旅人",
        "avatar_url": "https://api.dicebear.com/7.x/thumbs/svg?seed=user_1",
        "phone": "138****8000",
        "bio": "走遍中国大好河山",
        "gender": 1,
        "birthday": "1995-06-15",
        "travel_count": 12,
        "follower_count": 128,
        "following_count": 56,
        "created_at": "2026-01-01T00:00:00Z"
    }
}
```

### 3.2 更新个人信息

| 项目 | 值 |
|------|-----|
| **路径** | `PUT /api/v1/user/profile` |
| **认证** | ✅ 需要 |
| **对齐状态** | ✅ |

**请求体（所有字段可选）：**
```json
{
    "nickname": "新昵称",
    "bio": "新的简介",
    "gender": 1,
    "birthday": "1995-06-15"
}
```

### 3.3 修改密码

| 项目 | 值 |
|------|-----|
| **路径** | `PUT /api/v1/user/change-password` |
| **认证** | ✅ 需要 |
| **对齐状态** | ✅ |

**请求体：**
```json
{
    "old_password": "OldPass123",
    "new_password": "NewPass456"
}
```

---

## 4. 旅行内容接口 — `/api/v1/travel/*`

> 创建/删除帖子需认证，列表/详情可匿名访问

### 4.1 获取帖子列表

| 项目 | 值 |
|------|-----|
| **路径** | `GET /api/v1/travel/posts` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

**查询参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| page | int | 否 | 页码，默认1 |
| page_size | int | 否 | 每页数量，默认20，最大50 |

**响应：**
```json
{
    "code": 0,
    "message": "success",
    "data": {
        "items": [
            {
                "id": 1,
                "user_id": 1,
                "title": "大理洱海骑行日记",
                "content": "今天沿着洱海骑行了一整天...",
                "location": "大理·洱海",
                "cover_url": "https://picsum.photos/seed/post_1/800/600",
                "image_urls": ["https://picsum.photos/seed/post_1_0/800/600"],
                "like_count": 42,
                "comment_count": 8,
                "created_at": "2026-06-10T10:30:00Z",
                "user": {
                    "id": 1,
                    "nickname": "山海旅人",
                    "avatar_url": "https://api.dicebear.com/7.x/thumbs/svg?seed=user_1"
                }
            }
        ],
        "total": 30,
        "page": 1,
        "page_size": 20,
        "has_more": true
    }
}
```

### 4.2 获取帖子详情

| 项目 | 值 |
|------|-----|
| **路径** | `GET /api/v1/travel/posts/:id` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

**路径参数：** `id` — 帖子ID

**响应：** 同列表中的单条数据格式

### 4.3 创建帖子

| 项目 | 值 |
|------|-----|
| **路径** | `POST /api/v1/travel/posts` |
| **认证** | ✅ 需要 |
| **对齐状态** | ✅ |

**请求体：**
```json
{
    "title": "我的新旅行",
    "content": "今天的旅行经历...",
    "location": "云南·丽江"
}
```

### 4.4 删除帖子

| 项目 | 值 |
|------|-----|
| **路径** | `DELETE /api/v1/travel/posts/:id` |
| **认证** | ✅ 需要 |
| **对齐状态** | ✅ |

**路径参数：** `id` — 帖子ID

---

## 5. 健康检查

| 项目 | 值 |
|------|-----|
| **路径** | `GET /health` |
| **认证** | ❌ 无需 |
| **对齐状态** | ✅ |

---

## 6. 对齐差异说明

| # | 差异项 | 说明 | 处理方式 |
|---|--------|------|----------|
| 1 | 帖子详情中 `user` 为精简对象 | 仅含 `id/nickname/avatar_url`，不含 `bio/travelCount` 等 | iOS端MockData有完整字段，联调时以后端返回为准 |
| 2 | `is_liked`/`is_bookmarked` | 后端当前不返回（社交模块后续迭代） | iOS端用 `@State` 本地管理 |
| 3 | 登录响应 `user` 为精简版 | 仅含 `id/nickname/avatar_url/phone`（phone脱敏） | iOS端已对齐 |
| 4 | 字段命名 | 后端统一使用snake_case | iOS端已对齐 |

---

## 7. 对齐确认签名

| 角色 | 确认状态 | 确认日期 |
|------|----------|----------|
| iOS开发工程师 | ✅ 已确认 | 2026-06-12 |
| 后端开发工程师 | ✅ 已确认 | 2026-06-12 |

---

> **文档版本**: v1.0  
> **项目**: meet  
> **后端API地址**: http://124.223.114.103/api/v1/  
> **iOS端Mock模式**: `isMockMode = true`（联调时切换为 `false`）
