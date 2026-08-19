
import { FRAGMENT_USER_FIELD } from './user'

export const FRAGMENT_PROJECT_FIELD = `
  ${FRAGMENT_USER_FIELD}
  fragment projectFields on Project {
    id
    name
    description
    owner {
      ...userFields
    }
  }
`