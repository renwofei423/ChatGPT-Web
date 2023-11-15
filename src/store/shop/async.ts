import { getProduct } from '@/request/api';
import shopStore from './slice';
import wxpay from '@/assets/wxpay.png';
import zfbpay from '@/assets/zfbpay.png';
import qqpay from '@/assets/qqpay.png';

interface PayType {
	icon: string;
	title: string;
	key: string;
}

// Define pay types outside the function, to not recreate it in every fetchProduct invocation
const payTypes: Record<string, PayType> = {
	wxpay: {
		icon: wxpay,
		title: '微信支付',
		key: 'wxpay'
	},
	alipay: {
		icon: zfbpay,
		title: '支付宝',
		key: 'alipay'
	},
	qqpay: {
		icon: qqpay,
		title: 'QQ支付',
		key: 'qqpay'
	},
};

async function fetchProduct() {
	const res = await getProduct()
	if (!res.code) {
		shopStore.getState().changeGoodsList(res.data.products);
		const payTyps: PayType[] = res.data.pay_types.map(type => payTypes[type]);
		shopStore.getState().changePayTypes(payTyps);
	}
	return res;
}

export default {
	fetchProduct
}