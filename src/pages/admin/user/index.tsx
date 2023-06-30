import UserHead from '@/components/UserHead'
import { delAdminUsers, getAdminUsers, putAdminUsers } from '@/request/adminApi'
import { UserInfo } from '@/types/admin'
import {
  ActionType,
  ModalForm,
  ProColumns,
  ProFormDatePicker,
  ProFormDigit,
  ProFormGroup,
  ProFormRadio,
  ProFormSelect,
  ProFormText
} from '@ant-design/pro-components'
import { ProTable } from '@ant-design/pro-components'
import { Tag, Button, Space, message, Form, Row, Col, Input, DatePicker, InputNumber } from 'antd'
import { useRef, useState } from 'react'

function UserPage() {
  const tableActionRef = useRef<ActionType>()
  const [form] = Form.useForm<UserInfo>()
  const [searchForm] = Form.useForm()
  const [edidInfoModal, setEdidInfoModal] = useState<{
    open: boolean
    info: UserInfo | undefined
  }>({
    open: false,
    info: undefined
  })

  const columns: ProColumns<UserInfo>[] = [
    {
      title: 'ID',
      dataIndex: 'id',
      width: 180
    },
    {
      title: '账号',
      width: 200,
      dataIndex: 'account'
    },
    {
      title: '积分',
      width: 100,
      dataIndex: 'integral',
      render: (_, data) => <a>{data.integral}分</a>
    },
    {
      title: '会员到期时间',
      dataIndex: 'vip_expire_time',
      render: (_, data) => {
        const today = new Date()
        today.setHours(0, 0, 0, 0)
        const todayTime = today.getTime()
        const userSubscribeTime = new Date(data.vip_expire_time).getTime()
        return (
          <Space wrap>
            <Tag>{data.vip_expire_time}</Tag>
            {userSubscribeTime < todayTime && <Tag color="red">已过期</Tag>}
          </Space>
        )
      }
    },
    {
      title: '超级会员到期时间',
      dataIndex: 'svip_expire_time'
    },
    {
      title: '用户信息',
      dataIndex: 'user_id',
      width: 160,
      render: (_, data) => {
        return <UserHead headimgurl={data.avatar} nickname={data.nickname} />
      }
    },
    {
      title: 'ip',
      dataIndex: 'ip'
    },
    {
      title: '状态',
      dataIndex: 'status',
      width: 100,
      render: (_, data) => {
        return <Tag color="green">{data.status === 1 ? '正常' : '异常'}</Tag>
      }
    },
    {
      title: '创建时间',
      dataIndex: 'create_time'
    },
    {
      title: '更新时间',
      dataIndex: 'update_time'
    },
    {
      title: '操作',
      width: 150,
      valueType: 'option',
      fixed: window.innerWidth <= 768 ? undefined : 'right', // 根据屏幕宽度动态设置 fixed 属性
      render: (_, data) => [
        <Button
          key="edit"
          type="link"
          onClick={() => {
            setEdidInfoModal(() => {
              form?.setFieldsValue({
                ...data
              })
              return {
                open: true,
                info: data
              }
            })
          }}
        >
          编辑
        </Button>,
        <Button
          key="del"
          type="text"
          danger
          onClick={() => {
            delAdminUsers({
              id: data.id
            }).then((res) => {
              if (res.code) return
              message.success('删除成功')
              tableActionRef.current?.reloadAndRest?.()
            })
          }}
        >
          删除
        </Button>
      ]
    }
  ]

  const handleSearch = () => {
    const searchValues = searchForm.getFieldsValue()
    tableActionRef.current?.reloadAndRest?.()
  }

  return (
    <div>
      <Form form={searchForm} onFinish={handleSearch}>
        <Row gutter={24}>
          <Col>
            <Form.Item name="account" label = "账户">
              <Input placeholder="输入账号,支持关键词" />
            </Form.Item>
          </Col>
          <Form.Item label="积分范围" name="scoreRange">
          <Input.Group compact>
            <Form.Item name={['scoreRange', 'min']} noStyle>
              <InputNumber
                placeholder="最小积分"
                min={0}
                max={1000000}
                style={{ width: '50%' }}
              />
            </Form.Item>
            <Form.Item
              name={['scoreRange', 'max']}
              noStyle
              rules={[
                {
                  validator: (_, value) => {
                    if (value && value < 0) {
                      return Promise.reject(new Error('最大积分不能小于0'));
                    }
                    return Promise.resolve();
                  },
                },
              ]}
            >
              <InputNumber
                placeholder="最大积分"
                min={0}
                max={1000000}
                style={{ width: '50%' }}
              />
            </Form.Item>
          </Input.Group>
          </Form.Item>
          <Col>
            <Form.Item name="createTimeRange" label="用户注册时间">
              <DatePicker.RangePicker
                placeholder={['起始时间', '结束时间']}
                allowClear
              />
            </Form.Item>
          </Col>
          <Col>
            <Form.Item name="vipTimeRange" label="VIP范围">
              <DatePicker.RangePicker
                placeholder={['起始时间', '结束时间']}
                allowClear
              />
            </Form.Item>
          </Col>
          <Col>
            <Form.Item name="svipTimeRange" label="SVIP范围">
              <DatePicker.RangePicker
                placeholder={['起始时间', '结束时间']}
                allowClear
              />
            </Form.Item>
          </Col>
          <Col>
            <Form.Item>
              <Button type="primary" htmlType="submit">
                确认
              </Button>
            </Form.Item>
          </Col>
        </Row>
      </Form>
      <ProTable
        actionRef={tableActionRef}
        columns={columns}
        params={{}}
        pagination={{}}
        scroll={{
          x: 1800
        }}
        request={async (params, sorter, filter) => {
          const searchValues = searchForm.getFieldsValue()

          // 将搜索值添加到请求参数中
          const queryParams = {
            ...searchValues,
            page: params.current || 1,
            page_size: params.pageSize || 10
          }
          console.log('queryParams',queryParams)
          // 表单搜索项会从 params 传入，传递给后端接口。
          const res = await getAdminUsers({
            page: queryParams.page || 1,
            page_size: queryParams.pageSize || 10,
            account: queryParams.account ?? '',
            scoreMin: queryParams.scoreRange !== undefined ? queryParams.scoreRange.min : 0,
            scoreMax: queryParams.scoreRange !== undefined ? queryParams.scoreRange.max : 0,
            createTimeStart: (queryParams.createTimeRange !== undefined && queryParams.createTimeRange !== null) ? 
                `${queryParams.createTimeRange?.[0].$y}-${queryParams.createTimeRange?.[0].$M + 1}-${queryParams.createTimeRange?.[0].$D}`
                : '', 
            createTimeEnd: (queryParams.createTimeRange !== undefined && queryParams.createTimeRange !== null)  ? 
                `${queryParams.createTimeRange?.[1].$y}-${queryParams.createTimeRange?.[1].$M + 1}-${queryParams.createTimeRange?.[1].$D}`
                : '',
            vipTimeStart: (queryParams.vipTimeRange !== undefined && queryParams.vipTimeRange !== null)  ?
            `${queryParams.vipTimeRange?.[0].$y}-${queryParams.vipTimeRange?.[0].$M + 1}-${queryParams.vipTimeRange?.[0].$D}`
                : '',
            vipTimeEnd: (queryParams.vipTimeRange !== undefined && queryParams.vipTimeRange !== null) ?
                `${queryParams.vipTimeRange?.[1].$y}-${queryParams.vipTimeRange?.[1].$M + 1}-${queryParams.vipTimeRange?.[1].$D}`
                : '',
            svipTimeStart: (queryParams.svipTimeRange !== undefined && queryParams.svipTimeRange !== null) ?
                `${queryParams.svipTimeRange?.[0].$y}-${queryParams.svipTimeRange?.[0].$M + 1}-${queryParams.svipTimeRange?.[0].$D}`
                : '',
            svipTimeEnd: (queryParams.svipTimeRange !== undefined && queryParams.svipTimeRange !== null) ?
                `${queryParams.svipTimeRange?.[1].$y}-${queryParams.svipTimeRange?.[1].$M + 1}-${queryParams.svipTimeRange?.[1].$D}`
                : '',
          })
          return Promise.resolve({
            data: res.data.rows,
            total: res.data.count,
            success: true
          })
        }}
        toolbar={{
          actions: []
        }}
        rowKey="id"
        search={false}
        bordered
      />
      <ModalForm<UserInfo>
        title="用户信息"
        open={edidInfoModal.open}
        form={form}
        initialValues={{
          status: 1
        }}
        onOpenChange={(visible) => {
          if (!visible) {
            form.resetFields()
          }
          setEdidInfoModal((info) => {
            return {
              ...info,
              open: visible
            }
          })
        }}
        onFinish={async (values) => {
          if (!edidInfoModal.info?.id) return false
          const res = await putAdminUsers({
            ...values,
            id: edidInfoModal.info?.id
          })
          if (res.code) {
            message.error('编辑失败')
            return false
          }
          tableActionRef.current?.reload?.()
          return true
        }}
        size="large"
        modalProps={{
          cancelText: '取消',
          okText: '提交'
        }}
      >
        <ProFormGroup>
          <ProFormText
            width="md"
            name="account"
            label="用户账号"
            rules={[{ required: true, message: '请输入用户账号' }]}
          />
          <ProFormRadio.Group
            name="role"
            label="角色"
            radioType="button"
            options={[
              {
                label: '用户',
                value: 'user'
              },
              {
                label: '管理员',
                value: 'administrator'
              }
            ]}
            rules={[{ required: true, message: '请输入剩余积分' }]}
          />
          <ProFormRadio.Group
            name="status"
            label="状态"
            radioType="button"
            options={[
              {
                label: '异常',
                value: 0
              },
              {
                label: '正常',
                value: 1
              }
            ]}
            rules={[{ required: true, message: '请输入剩余积分' }]}
          />
        </ProFormGroup>
        <ProFormGroup>
          <ProFormText
            name="nickname"
            label="用户名称"
            rules={[{ required: true, message: '请输入用户名称' }]}
          />
          <ProFormText
            width="lg"
            name="avatar"
            label="用户头像"
            rules={[{ required: true, message: '请输入用户头像' }]}
          />
        </ProFormGroup>

        <ProFormGroup>
          <ProFormDigit
            label="剩余积分"
            name="integral"
            min={0}
            max={1000000}
            rules={[{ required: true, message: '请输入剩余积分' }]}
          />
          <ProFormDatePicker
            name="vip_expire_time"
            label="会员截止日期"
            rules={[{ required: true, message: '请输入剩余积分' }]}
          />
          <ProFormDatePicker
            name="svip_expire_time"
            label="超级会员截止日期"
            rules={[{ required: true, message: '请输入剩余积分' }]}
          />
        </ProFormGroup>
      </ModalForm>
    </div>
  )
}

export default UserPage
