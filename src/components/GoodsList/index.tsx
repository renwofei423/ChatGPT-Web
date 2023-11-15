import { ProductInfo } from '@/types'
import styles from './index.module.less'
import { useEffect, useState } from 'react'

interface GoodsListProps {
  list: Array<ProductInfo>;
  onChange: (item: ProductInfo) => void;
}

const GoodsList: React.FC<GoodsListProps> = ({ list, onChange }) => {
  const [selectItem, setSelectItem] = useState<ProductInfo>()

  useEffect(() => {
    if (selectItem?.id) {
      onChange(selectItem)
    }
  }, [selectItem, onChange])

  const getItemClassNames = (item: ProductInfo) =>
      selectItem?.id === item.id
          ? `${styles.goodsList_item} ${styles.goodsList_item_select}`
          : styles.goodsList_item

  const getItemLevelType = (item: ProductInfo) =>
      item.level === 1 ? '会员' : item.level === 2 ? '超级会员' : '超级特惠'

  const getItemValue = (item: ProductInfo) =>
      item.type === 'integral' ? `${item.value}积分` : `${item.value}天`

  const getItemPrice = (item: ProductInfo) =>
      (item.price / 100).toFixed(2)

  const getOriginalPrice = (item: ProductInfo) =>
      item.original_price ? `¥${(item.original_price / 100).toFixed(2)}` : null

  return (
      <div className={styles.goodsList}>
        {list.map((item) => (
            <div
                key={item.id}
                className={getItemClassNames(item)}
                onClick={() => { setSelectItem(item) }}
            >
              <p className={styles.goodsList_item_level}>{getItemLevelType(item)}</p>
              <h3>{getItemValue(item)}</h3>
              <div className={styles.goodsList_item_price}>
                <p className={styles.sales_price}>
                  {getItemPrice(item)}<span>元</span>
                </p>
                {getOriginalPrice(item) &&
                    <p className={styles.original_price}>{getOriginalPrice(item)}</p>}
              </div>
              <span className={styles.goodsList_item_tag}>{item.badge}</span>
            </div>
        ))}
      </div>
  )
}

export default GoodsList