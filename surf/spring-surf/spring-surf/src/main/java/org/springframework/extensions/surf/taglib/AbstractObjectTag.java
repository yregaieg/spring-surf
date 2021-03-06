/*
 * Copyright (C) 2005-2015 Alfresco Software Limited.
 *
 * This file is part of Alfresco
 *
 * Alfresco is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Alfresco is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Alfresco. If not, see <http://www.gnu.org/licenses/>.
 */

package org.springframework.extensions.surf.taglib;

/**
 * 
 * @author David Draper
 * @author muzquiano
 */
public abstract class AbstractObjectTag extends RenderServiceTag
{
    private static final long serialVersionUID = 5383361788731531793L;

    private String pageId = null;
    private String pageTypeId = null;
    private String objectId = null;
    private String formatId = null;

    /**
     * <p>The life-cycle of a custom JSP tag is that the class is is instantiated when it is first required and
     * then re-used for all subsequent invocations. When a JSP has non-mandatory properties it means that the 
     * setters for those properties will not be called if the properties are not provided and the old values
     * will still be available which can corrupt the behaviour of the code. In order to prevent this from happening
     * we should override the <code>release</code> method to ensure that all instance variables are reset to their
     * initial state.</p>
     */
    @Override
    public void release()
    {
        super.release();
        this.pageId = null;
        this.pageTypeId = null;
        this.objectId = null;
        this.formatId = null;
    }
    
    public void setPage(String pageId)
    {
        this.pageId = pageId;
    }

    public String getPage()
    {
        return this.pageId;
    }
    
    public void setPageType(String pageTypeId)
    {
        this.pageTypeId = pageTypeId;
    }
    
    public String getPageType()
    {
        return this.pageTypeId;
    }
    
    public void setObject(String objectId)
    {
        this.objectId = objectId;
    }
    
    public String getObject()
    {
        return this.objectId;
    }

    public void setFormat(String formatId)
    {
        this.formatId = formatId;
    }

    public String getFormat()
    {
        return this.formatId;
    }
}
