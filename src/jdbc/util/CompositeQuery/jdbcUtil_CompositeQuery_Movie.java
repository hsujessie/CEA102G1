package jdbc.util.CompositeQuery;

import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

public class jdbcUtil_CompositeQuery_Movie {
	public static String get_aCondition_For_MySql(String columnName, String value) {
		String aCondition = null;
		System.out.println("columnName: " + columnName);
		System.out.println("value: " + value);
		
		if("mov_no".equals(columnName)) {
			aCondition = columnName + "=" + value;
		}
		else if("mov_type".equals(columnName) || "mov_ondate".equals(columnName)) {
			aCondition = columnName + "=" + "'" + value + "'";
		}
		
		return aCondition + " ";
	}
	
	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for(String key : keys) {
			String value = map.get(key)[0];
			if(value != null && value.trim().length() != 0 && !"action".contentEquals(key)) {
				count++;
				String aCondition = get_aCondition_For_MySql(key, value.trim());
				
				if(count == 1) {
					whereCondition.append(" where " + aCondition);
				}else {
					whereCondition.append(" and " + aCondition);
				}

				System.out.println("���e�X�d�߸�ƪ�����count = " + count);
			}
		}
		
		return whereCondition.toString();
	}

	public static void main(String args[]) {
		// �t�X req.getParameterMap()��k �^�� java.util.Map<java.lang.String,java.lang.String[]> ������
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("movno", new String[] { "1" });
		map.put("movtype", new String[] { "�ʵe��" });
		map.put("movondate", new String[] { "2020-12-25" });
		map.put("action", new String[] { "getXXX" }); // �`�NMap�̭��|�t��action��key

		String finalSQL = "select * from movie "
			       		   + jdbcUtil_CompositeQuery_Movie.get_WhereCondition(map)
			       		   + "order by movno";
		System.out.println("����finalSQL = " + finalSQL);
	}
}
