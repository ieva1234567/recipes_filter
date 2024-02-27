import { useEffect, useState } from "react"
import axios from "axios"

export default function useRecipesSearch(pageNumber, finalQuery, siteIdentifier) {

  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(false)
  const [recipes, setRecipes] = useState([])
  const [hasMore, setHasMore] = useState(false)

  useEffect(() => {
    setRecipes([])
  }, [finalQuery, siteIdentifier])

  function uniqByKeepLast( data, key) {
    return [
      ... new Map(
        data.map( x => [key(x), x])
      ).values( )
    ]
  }

  useEffect(() => {
    setLoading(true)
    setError(false)
    let cancel
    axios({
      method: 'GET',
      url: '/api/v1/recipes/index',
      params: { page: pageNumber, fQuery: finalQuery, sIdentifier: siteIdentifier},
      cancelToken: new axios.CancelToken(c => cancel = c)
    }).then(res => {
      setRecipes(prevRecipes => {
        return uniqByKeepLast([...prevRecipes, ...res.data.map(b=>({title: b.title, id: b.id, slug: b.slug}))], it=>it.id)
      })
      setHasMore(res.data.length > 0)
      setLoading(false)
    })
  }, [pageNumber, finalQuery, siteIdentifier])

  return { loading, error, recipes, hasMore }
}
