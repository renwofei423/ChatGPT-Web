/* eslint-disable no-console */
/* eslint-disable no-useless-catch */
/* eslint-disable @typescript-eslint/no-unused-vars */
import { ChatGpt, ChatsInfo, RequestLoginParams } from '@/types'
import userStore from '../user/slice'
import { chatHistory, getRooms, getUserInfo, postLogin, putUserPassword } from '@/request/api'
import chatStore from '../chat/slice'

// 登录
export async function fetchLogin(params: RequestLoginParams) {
  const response = await postLogin(params)
  if (!response.code) {
    userStore.getState().login({ ...response.data })
  }
  return response
}

export async function getRoomLatest(): Promise<string> {
  try {
    const roomsResult = await getRooms();
    if (roomsResult.code !== -1 && roomsResult.data.count >= 1) {
      const latestRoomId = roomsResult.data.rows[0].room_id;
      return latestRoomId;
    } else {
      return '';
    }
  } catch (error) {
    throw error;
  }
}

export async function getMysqlChats(nowId: string): Promise<Array<ChatsInfo>> {
  try {
    const roomsResult = await getRooms();
    if (roomsResult.code !== -1 && roomsResult.data.count >= 1) {
      const mysqlChats: Array<ChatsInfo> = [];
      const promises: Array<Promise<void>> = [];
      for (const roomElement of roomsResult.data.rows) {
        const chatInfo: ChatsInfo = {
          path: roomElement.room_id,
          id: roomElement.room_id,
          name: roomElement.title,
          data: [],
        };
        if(nowId === roomElement.room_id){
          const gptInfoArr: Array<ChatGpt> = [];
          const messageResult = await chatHistory({ roomId: roomElement.room_id });
          messageResult.data.rows.forEach((messageElement) => {
            const gptInfo: ChatGpt = {
              id: messageElement.message_id,
              text: messageElement.content,
              dateTime: messageElement.create_time,
              status: 'pass',
              role: messageElement.role,
              requestOptions: {
                prompt: messageElement.content,
                options: {
                  model: messageElement.model,
                  temperature: messageElement.temperature,
                  presence_penalty: parseFloat(messageElement.presence_penalty),
                  frequency_penalty: messageElement.frequency_penalty,
                  max_tokens: messageElement.max_tokens,
                },
                parentMessageId: messageElement.parent_message_id,
                selectChatIdStr: messageElement.room_id,
                userMessageId: messageElement.message_id,
                assistantMessageId: messageElement.message_id,
              },
            };
            gptInfoArr.push(gptInfo);
          });
          chatInfo.data = gptInfoArr;
        }
        mysqlChats.push(chatInfo);
      }
      return mysqlChats;
    } else {
      return [];
    }
  } catch (error) {
    throw error;
  }
}

export async function getNowChats(nowId: string) {
  const { updateChats } = chatStore()
  // 查找mysql中对话rooms
  getMysqlChats(nowId).then(mysqlChats => {
    console.log('mysqlChats',mysqlChats)
    updateChats(mysqlChats);
  }).catch(error => {
    console.error(error);
  });
}

// 获取用户信息
export async function fetchUserInfo() {
  const response = await getUserInfo()
  if (!response.code) {
    userStore.getState().login({
      token: userStore.getState().token,
      user_info: response.data
    })
  }
  return response
}


// 重置用户密码
export async function fetchUserPassword(params: RequestLoginParams) {
  const response = await putUserPassword(params)
  if (!response.code) {
    userStore.getState().logout();
  }
  return response
}

export default {
  fetchUserInfo,
  fetchLogin,
  fetchUserPassword
}
